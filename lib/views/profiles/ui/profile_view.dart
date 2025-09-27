import 'package:e_commerce_app_supabase/common/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/common/custom_derlight_bar.dart';
import 'package:e_commerce_app_supabase/core/loading_screen.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
import 'package:e_commerce_app_supabase/views/auth/login/ui/login_view.dart';
import 'package:e_commerce_app_supabase/views/profiles/ui/widgets/custom_card_profiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          showCustomDelightToastBar(
            context,
            "Logout successful",
            Icon(Icons.check, color: Colors.green),
          );
          loadingScreen(context, () => const LoginView());
        }
        if (state is LogoutFailure) {
          showCustomDelightToastBar(
            context,
            state.message,
            const Icon(Icons.error, color: Colors.red),
          );
        }
      },
      builder: (context, state) {
        return state is LogoutLoading
            ? CustomCircleProgIndicator()
            : SafeArea(
                child: SingleChildScrollView(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                'assets/user_images.png',
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Username",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text("John Doe"),
                                        SizedBox(height: 4),
                                        Text("123435345"),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("Edit"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          CustomCardProfiles(text: "Address"),
                          SizedBox(height: size.height * 0.01),
                          CustomCardProfiles(text: "Wishlist"),
                          SizedBox(height: size.height * 0.01),
                          CustomCardProfiles(text: "Payment"),
                          SizedBox(height: size.height * 0.01),
                          CustomCardProfiles(text: "Help"),
                          SizedBox(height: size.height * 0.01),
                          CustomCardProfiles(text: "Support"),
                          SizedBox(height: size.height * 0.01),
                          ElevatedButton(
                            onPressed: () async {
                              await context
                                  .read<AuthenticationCubit>()
                                  .signOut();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                            ),
                            child: const Text("Sign Out"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
