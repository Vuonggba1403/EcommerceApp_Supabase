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

  /// 🧩 Lấy danh sách tất cả sản phẩm
  Future<void> getProducts() async {
    emit(GetDataLoading());
    try {
      final response = await _apiServices.getData(
        "products_table?select=*,favorite_products(*),purchase_table(*)",
      );

      products = (response.data as List)
          .map((product) => ProductModel.fromJson(product))
          .toList();

      emit(GetDataSuccess(products));
    } catch (e) {
      log("❌ Error fetching products: $e");
      emit(GetDataFailure(e.toString()));
    }
  }

  /// 🔍 Tìm kiếm theo từ khóa
  void searchProducts(String query) {
    emit(SearchLoading());

    if (query.trim().isEmpty) {
      emit(SearchSuccess([]));
      return;
    }

    final lowerQuery = query.toLowerCase();
    final results = products.where((p) {
      final name = (p.productName ?? '').toLowerCase();
      return name.contains(lowerQuery);
    }).toList();

    emit(SearchSuccess(results));
  }

  /// ❌ Xóa kết quả tìm kiếm
  void clearSearch() {
    emit(SearchCleared());
  }

  /// 🏷️ Lọc sản phẩm theo danh mục (category)
  void searchByCategory(String category) {
    emit(CategoryFilterLoading());

    if (category.trim().isEmpty) {
      emit(CategoryFilterSuccess(products));
      return;
    }

    final lowerCategory = category.trim().toLowerCase();
    final filtered = products.where((p) {
      final productCategory = (p.category ?? '').trim().toLowerCase();
      return productCategory == lowerCategory;
    }).toList();

    emit(CategoryFilterSuccess(filtered));
  }
}
