part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeCubitInitial extends HomeState {}

final class GetDataLoading extends HomeState {}

final class GetDataSuccess extends HomeState {}

final class GetDataFailure extends HomeState {}
