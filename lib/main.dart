import 'package:e_commerce_app_supabase/core/functions/my_observer.dart';
import 'package:e_commerce_app_supabase/core/sensitive_data.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/splash/ui/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://abxdqxazcrrcuofnuktd.supabase.co',
    anonKey: anonKey,
  );
  Bloc.observer = MyObserver();
  runApp(OurMarket());
}

class OurMarket extends StatelessWidget {
  const OurMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit()..getUserData(),
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
