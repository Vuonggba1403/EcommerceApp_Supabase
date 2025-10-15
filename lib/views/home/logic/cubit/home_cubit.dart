import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_supabase/core/functions/api_services.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeCubitInitial());

  final ApiServices _apiServices = ApiServices();
  final String userId = Supabase.instance.client.auth.currentUser!.id;

  List<ProductModel> products = [];
  List<String> favoriteProductIds = []; // 🔥 danh sách id sản phẩm yêu thích

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

      // ✅ Lấy danh sách id sản phẩm yêu thích của user hiện tại
      final favRes = await _apiServices.getData(
        "favorite_products?select=product_id&for_user=eq.$userId",
      );

      favoriteProductIds = (favRes.data as List)
          .map((item) => item['product_id'] as String)
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

  /// ❤️ Thêm sản phẩm vào danh sách yêu thích
  Future<void> addToFavorite(String productId) async {
    emit(addToFavoriteLoading());
    try {
      await _apiServices.postData("favorite_products", {
        "is_favorite": true,
        "for_user": userId,
        "for_product": productId,
      });
      favoriteProductIds.add(productId);
      emit(addToFavoriteSuccess());
    } catch (e) {
      log("❌ Error adding to favorite: $e");
      emit(addToFavoriteFailure());
    }
  }

  /// 🧠 Kiểm tra sản phẩm có được yêu thích không
  bool isFavorite(String productId) {
    return favoriteProductIds.contains(productId);
  }
}
