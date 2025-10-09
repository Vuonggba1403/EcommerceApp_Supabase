import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/product_details/logic/cubit/product_details_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/color_selector.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/comment_list.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/description_selection.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/quality_selector.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/size_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  String selectedSize = 'S';
  Color selectedColor = Colors.green;
  int quantity = 1;

  final List<String> sizes = ['S', 'M', 'L', 'XL'];
  final List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.grey,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return state is GetRateLoading
              ? CustomCircleProgIndicator()
              : Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    title: Text(
                      widget.product.productName ?? "Product Details",
                    ),
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0,
                    foregroundColor: AppColors.secondColor,
                  ),
                  body: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                CacheImage(url: widget.product.imageUrl ?? ''),
                                const SizedBox(height: 16),
                                _buildProductDetailsView(size, cubit),
                              ],
                            ),
                          ),
                        ),
                        _buildBottomSection(),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }

  // --- Product Info Section ---
  Widget _buildProductDetailsView(Size size, dynamic cubit) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.product.productName ?? "Unnamed Product",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "${widget.product.price ?? '0'} VND",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          //size selector
          SizeSelector(
            selectedSize: selectedSize,
            sizes: sizes,
            onSelect: (s) => setState(() => selectedSize = s),
          ),

          const SizedBox(height: 20),
          //Color selector
          ColorSelector(
            selectedColor: selectedColor,
            colors: colors,
            onSelect: (c) => setState(() => selectedColor = c),
          ),
          const SizedBox(height: 20),
          //Quantity selector
          QuantitySelector(
            quantity: quantity,
            onIncrease: () => setState(() => quantity++),
            onDecrease: () {
              if (quantity > 1) {
                setState(() => quantity--);
              }
            },
          ),
          const SizedBox(height: 20),
          //Description
          DescriptionSection(description: widget.product.description ?? ''),
          const Divider(height: 40, thickness: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("${cubit.averageRate}"),
                  Icon(Icons.star, color: Colors.amber),
                ],
              ),
              Icon(Icons.favorite, color: Colors.grey),
            ],
          ),
          // --- Rating bar ---
          Center(
            child: Column(
              children: [
                Text(
                  "Rate this product",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  hintText: "Write a comment...",
                  keyboardType: TextInputType.text,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(Icons.send, color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Comments",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          CommentsList(),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  // --- Bottom Section ---
  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            "${widget.product.price ?? '0'} VND",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add to Bag',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added to cart: ${widget.product.productName} '
          '(Size: $selectedSize, Qty: $quantity)',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
