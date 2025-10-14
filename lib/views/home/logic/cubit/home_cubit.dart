import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_supabase/core/functions/api_services.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());

  final ApiServices _apiServices = ApiServices();
  List<ProductModel> products = [];
  List<ProductModel> searchResults = [];

  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      Response response = await _apiServices.getData(
        "products_table?select=*,favorite_products(*),purchase_table(*)",
      );

      products = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      emit(GetDataSuccess(products));
    } catch (e) {
      log(e.toString());
      emit(GetDataFailure());
    }
  }

  // 🔍 Hàm search sản phẩm
  void searchProducts(String query) {
    emit(SearchLoading());

    if (query.isEmpty) {
      emit(SearchSuccess([])); // Không có query thì trả về danh sách rỗng
      return;
    }

    final lowerQuery = query.toLowerCase();
    searchResults = products.where((p) {
      final name = (p.productName ?? '').toLowerCase();
      return name.contains(lowerQuery);
    }).toList();

    emit(SearchSuccess(searchResults));
  }

  void clearSearch() {
    searchResults.clear();
    emit(SearchCleared());
  }
}
