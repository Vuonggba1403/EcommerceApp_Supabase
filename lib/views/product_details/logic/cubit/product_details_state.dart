part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetRateLoading extends ProductDetailsState {}

final class GetRateSuccess extends ProductDetailsState {}

final class GetRateFailure extends ProductDetailsState {}

final class AddOrUpdateLoading extends ProductDetailsState {}

final class AddOrUpdateSuccess extends ProductDetailsState {}

final class AddOrUpdateFailure extends ProductDetailsState {}
