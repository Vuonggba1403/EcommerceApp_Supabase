import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app_supabase/core/functions/api_services.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/logic/models/rate_models.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final ApiServices _apiServices = ApiServices();

  List<RateModels> rates = [];

  int averageRate = 0;

  Future<void> getRates({required String productId}) async {
    emit(GetRateLoading());

    try {
      Response response = await _apiServices.getData(
        "rates_table?select=*&for_product=eq.$productId",
      );

      for (var rate in response.data) {
        rates.add(RateModels.fromJson(rate));
      }
      _getAverageRate();
      emit(GetRateSuccess());
    } catch (e) {
      log(e.toString());
      emit(GetRateError());
    }
  }

  void _getAverageRate() {
    for (var userRate in rates) {
      // log(userRate.rate.toString());
      if (userRate.rate != null) {
        averageRate += userRate.rate!;
      }
    }
    averageRate = averageRate ~/ rates.length;
  }
}
