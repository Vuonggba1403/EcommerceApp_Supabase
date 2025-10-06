import 'package:e_commerce_app_supabase/core/components/custom_backbutton.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favorites(22)",
          style: TextStyle(color: AppColors.secondColor),
        ),

        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, size: 50, color: AppColors.primaryColor),
              SizedBox(height: 20),
              Text("No Favorites yet!", style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  foregroundColor: AppColors.secondColor,
                  backgroundColor: AppColors.primaryColor,
                ),
                onPressed: () {},
                child: Text("Explore Categories"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
