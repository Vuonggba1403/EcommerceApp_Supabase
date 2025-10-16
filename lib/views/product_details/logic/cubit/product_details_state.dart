part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class GetRateLoading extends ProductDetailsState {}

final class GetRateSuccess extends ProductDetailsState {}

final class GetRateFailure extends ProductDetailsState {}

final class AddOrUpdateRateLoading extends ProductDetailsState {}

final class AddOrUpdateRateSuccess extends ProductDetailsState {}

final class AddOrUpdateRateFailure extends ProductDetailsState {}

final class AddCommentLoading extends ProductDetailsState {}

final class AddCommentSuccess extends ProductDetailsState {}

final class AddCommentFailure extends ProductDetailsState {}

// Favorite states
final class FavoriteStatusChanged extends ProductDetailsState {
  final bool isFavorite;
  FavoriteStatusChanged(this.isFavorite);
}

final class AddToFavoriteLoading extends ProductDetailsState {}

final class AddToFavoriteSuccess extends ProductDetailsState {}

final class AddToFavoriteFailure extends ProductDetailsState {}

final class RemoveFromFavoriteLoading extends ProductDetailsState {}

final class RemoveFromFavoriteSuccess extends ProductDetailsState {}

final class RemoveFromFavoriteFailure extends ProductDetailsState {}
