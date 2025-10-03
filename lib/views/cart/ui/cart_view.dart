import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(
          "Orders",
          style: TextStyle(color: AppColors.secondColor, fontSize: 22),
        ),
        centerTitle: true,
        // centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart, size: 50, color: AppColors.primaryColor),
            SizedBox(height: 20),
            Text("No Orders yet!", style: TextStyle(fontSize: 22)),
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
    );
  }
}
