import 'package:e_commerce_app_superbase/views/profiles/ui/widgets/custom_card_profiles.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
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
                    backgroundImage: AssetImage('assets/user_images.png'),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Username",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text("John Doe"),
                              SizedBox(height: 4),
                              Text("123435345"),
                            ],
                          ),
                        ),
                        TextButton(onPressed: () {}, child: const Text("Edit")),
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
                  onPressed: () {},
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
  }
}
