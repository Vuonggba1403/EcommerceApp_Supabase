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
  final ApiServices _apiServices = ApiServices();
  String userID = Supabase.instance.client.auth.currentUser!.id;
  List<RateModels> rates = [];
  int averageRate = 0;
  int userRate = 5;
  bool isFavorite = false; // Biến lưu trạng thái yêu thích cục bộ

  // Kiểm tra trạng thái yêu thích của sản phẩm
  Future<void> checkFavoriteStatus({required String productId}) async {
    try {
      // 🔹 Query database để kiểm tra
      Response response = await _apiServices.getData(
        "favorite_products?select=*&for_user=eq.$userID&for_product=eq.$productId",
      );
      // Nếu response.data không rỗng → Sản phẩm đã được yêu thích
      isFavorite = (response.data as List).isNotEmpty;

      emit(FavoriteStatusChanged(isFavorite)); // Cập nhật UI
    } catch (e) {
      log("Error checking favorite status: $e");
    }
  }

  // Thêm vào yêu thích
  Future<void> addToFavorite(String productId) async {
    emit(AddToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "is_favorite": true,
        "for_user": userID,
        "for_product": productId,
      });
      isFavorite = true;
      emit(AddToFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddToFavoriteFailure());
    }
  }

  // Xóa khỏi yêu thích
  Future<void> removeFromFavorite(String productId) async {
    emit(RemoveFromFavoriteLoading());
    try {
      await _apiServices.deleteData(
        "favorite_products?for_user=eq.$userID&for_product=eq.$productId",
      );
      isFavorite = false;
      emit(RemoveFromFavoriteSuccess());
    } catch (e) {
      log(e.toString());
      emit(RemoveFromFavoriteFailure());
    }
  }

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());
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

      // 🔹 Kiểm tra trạng thái yêu thích sau khi load xong ratings
      await checkFavoriteStatus(productId: productId);

      emit(GetRateSuccess()); // Thành công → UI hiển thị được
    } catch (e) {
      // Nếu lỗi → phát trạng thái lỗi
      emit(GetRateFailure());
    }
  }

  _getUserRate() {
    List<RateModels> userRates = rates.where((rate) {
      return rate.forUser == userID;
    }).toList();
    // Nếu người dùng hiện tại đã từng đánh giá => lấy ra số sao họ đã cho
    if (userRates.isNotEmpty) {
      userRate = userRates[0].rate!;
      //   userRate là "rate" của riêng currentUser,
      //   còn averageRate là trung bình "rate" của tất cả mọi người.
    }
    return userRates;
  }

  // trung bình số sao (averageRate)
  void _getAverageRate() {
    for (var userRate in rates) {
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    if (rates.isNotEmpty) {
      averageRate = averageRate ~/ rates.length;
    }
  }

  bool _isUserRateExist({required String productId}) {
    for (var rate in rates) {
      if (rate.forUser == userID && rate.forProduct == productId) {
        return true;
      }
    }
    return false;
  }

  // add or update user rate
  Future<void> addOrUpdateUserRate({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    //user rate exist ==> update for user rate
    //user doesn't exits ==> add rate
    String path = "rates_table?for_user=eq.$userID&for_product=eq.$productId";
    emit(AddOrUpdateRateLoading());
    try {
      if (_isUserRateExist(productId: productId)) {
        //patch rate
        await _apiServices.patchData(path, data);
      } else {
        // post Rate(),
        await _apiServices.postData(path, data);
      }
      emit(AddOrUpdateRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddOrUpdateRateFailure());
    }
  }

  // add Comment
  Future<void> addComment({required Map<String, dynamic> data}) async {
    emit(AddCommentLoading());
    try {
      await _apiServices.postData("comments_table", data);
      emit(AddCommentSuccess());
    } catch (e) {
      log(e.toString());
      emit(AddCommentFailure());
    }
  }
}
