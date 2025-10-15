part of 'home_cubit.dart';

abstract class HomeState {}

class HomeCubitInitial extends HomeState {}

/// --- Lấy dữ liệu ---
class GetDataLoading extends HomeState {}

class GetDataSuccess extends HomeState {
  final List<ProductModel> products;
  GetDataSuccess(this.products);
}

class GetDataFailure extends HomeState {
  final String error;
  GetDataFailure(this.error);
}

/// --- Search ---
class SearchLoading extends HomeState {}

class SearchSuccess extends HomeState {
  final List<ProductModel> results;
  SearchSuccess(this.results);
}

class SearchCleared extends HomeState {}

/// --- Filter theo Category ---
class CategoryFilterLoading extends HomeState {}

class CategoryFilterSuccess extends HomeState {
  final List<ProductModel> filtered;
  CategoryFilterSuccess(this.filtered);
}

final class addToFavoriteSuccess extends HomeState {}

final class addToFavoriteLoading extends HomeState {}

final class addToFavoriteFailure extends HomeState {}

final class removeFromFavoriteLoading extends HomeState {}

final class removeFromFavoriteSuccess extends HomeState {}

final class removeFromFavoriteFailure extends HomeState {}
