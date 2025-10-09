import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_supabase/core/functions/api_services.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/logic/models/rate_models.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  // Gọi API (qua Dio) thông qua class ApiServices
  final ApiServices _apiServices = ApiServices();

  // Danh sách toàn bộ các đánh giá (rate) mà người dùng đã gửi cho sản phẩm này
  List<RateModels> rates = [];

  // averageRate: trung bình số sao của tất cả người dùng đánh giá
  int averageRate = 0;

  // userRate: số sao mà NGƯỜI DÙNG HIỆN TẠI đã đánh giá sản phẩm này
  // Mặc định 5 (có thể thay đổi sau khi tải dữ liệu thật từ server)
  int userRate = 5;

  // 👉 Hàm này dùng để tải toàn bộ đánh giá của một sản phẩm từ Supabase
  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading()); // Phát trạng thái "đang tải"

    try {
      // Gửi request GET tới bảng "rates_table" trong Supabase
      // Lấy tất cả record có "for_product" trùng với productId đang xem
      Response response = await _apiServices.getData(
        "rates_table?select=*&for_product=eq.$productId",
      );

      // Duyệt từng đánh giá (rate) trong phản hồi và chuyển sang model RateModels
      for (var rate in response.data) {
        rates.add(RateModels.fromJson(rate));
      }

      // Gọi hàm để tính trung bình số sao của toàn bộ đánh giá
      _getAverageRate();

      // Lọc ra danh sách rate của riêng người dùng hiện tại (theo userId Supabase)
      _getUserRate();

      // // Log ra để kiểm tra
      // log("userRate Length = ${userRates.length}");
      // log("rate.forUser = ${rates[0].forUser}");
      // log("userID = ${Supabase.instance.client.auth.currentUser!.id}");
      // log("User rate is $userRate"); // Số sao user hiện tại đã đánh giá

      emit(GetRateSuccess()); // Thành công → UI hiển thị được
    } catch (e) {
      // Nếu lỗi → phát trạng thái lỗi
      emit(GetRateError());
    }
  }

  _getUserRate() {
    List<RateModels> userRates = rates
        .where(
          (rate) =>
              rate.forUser == Supabase.instance.client.auth.currentUser!.id,
        )
        .toList();

    // Nếu người dùng hiện tại đã từng đánh giá => lấy ra số sao họ đã cho
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
      // 🧠 Mối liên hệ:
      //   userRate là "rate" của riêng currentUser,
      //   còn averageRate là trung bình "rate" của tất cả mọi người.
    }
    return userRates;
  }

  // 👉 Hàm này tính trung bình số sao (averageRate)
  void _getAverageRate() {
    // Duyệt toàn bộ các đánh giá của người dùng
    for (var userRate in rates) {
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }

    // Tính trung bình (chia lấy phần nguyên, bỏ phần lẻ)
    averageRate = averageRate ~/ rates.length;

    // 🧠 averageRate và userRate khác nhau:
    //   - averageRate = trung bình sao của TẤT CẢ người dùng
    //   - userRate = số sao mà NGƯỜI DÙNG HIỆN TẠI đã đánh giá
  }
}
