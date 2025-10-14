part of 'home_cubit.dart';

abstract class HomeState {}

class HomeCubitInitial extends HomeState {}

// Loading data from API
class GetDataLoading extends HomeState {}

class GetDataSuccess extends HomeState {
  final List<ProductModel> products;
  GetDataSuccess(this.products);
}

class GetDataFailure extends HomeState {}

// Search States
class SearchLoading extends HomeState {}

class SearchSuccess extends HomeState {
  final List<ProductModel> results;
  SearchSuccess(this.results);
}

class SearchCleared extends HomeState {}
