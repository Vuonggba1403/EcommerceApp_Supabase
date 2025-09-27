import 'package:e_commerce_app_supabase/core/my_observer.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/login_view.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/register_view.dart';
import 'package:e_commerce_app_supabase/views/auth/nav_bar/ui/main_home_view.dart';
import 'package:e_commerce_app_supabase/views/home/ui/home_view.dart';
import 'package:e_commerce_app_supabase/views/splash/ui/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://abxdqxazcrrcuofnuktd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFieGRxeGF6Y3JyY3VvZm51a3RkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg2Nzg0NTMsImV4cCI6MjA3NDI1NDQ1M30.437lXY_wgXCdl0b_PfbCBgQmZdtA3dBCI2-RW4lSMP4',
  );
  Bloc.observer = MyObserver();
  runApp(OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: MaterialApp(
        title: "Our Market",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: "CircularStd",
          textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 15)),
        ),
        home: SplashView(),
      ),
    );
  }
}
