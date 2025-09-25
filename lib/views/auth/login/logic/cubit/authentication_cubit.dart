import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  // Lấy Supabase client toàn cục đã được khởi tạo trong Supabase.initialize()
  SupabaseClient client = Supabase.instance.client;
  //Login
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await client.auth.signInWithPassword(password: password, email: email);
      emit(LoginSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(LoginFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(LoginFailure(e.toString()));
    }
  }

  //Signup
  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    emit(SignUpLoading());
    try {
      await client.auth.signUp(password: password, email: email);
      emit(SignUpSuccess());
    } on AuthException catch (e) {
      log(e.toString());
      emit(SignUpFailure(e.message));
    } catch (e) {
      log(e.toString());
      emit(SignUpFailure(e.toString()));
    }
  }
}
