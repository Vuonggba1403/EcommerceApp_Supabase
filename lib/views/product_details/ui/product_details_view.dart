import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/components/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/product_details/logic/cubit/product_details_cubit.dart';
import 'package:e_commerce_app_supabase/views/product_details/ui/widgets/comment_list.dart';
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
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(widget.product.productName ?? "Product Details"),
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
                          _buildProductDetailsView(size),
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
  Widget _buildProductDetailsView(Size size) {
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
          _buildSizeSelector(),
          const SizedBox(height: 20),
          _buildColorSelector(),
          const SizedBox(height: 20),
          _buildQuantitySelector(),
          const SizedBox(height: 20),
          _buildDescription(),
          const Divider(height: 40, thickness: 2),
          _ratingBar(),
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
                onTap: () {
                  // Handle send comment action
                  print("1");
                },
                child: Container(
                  child: Icon(Icons.send, color: AppColors.primaryColor),
                  margin: EdgeInsets.only(left: 10),
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

  Widget _ratingBar() {
    return Center(
      child: Column(
        children: [
          const Text(
            'Rate this product',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ],
      ),
    );
  }

  // --- Size Selector ---
  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: sizes.map((size) {
            final isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() => selectedSize = size);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isSelected
                      ? Colors.blue.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.blue : Colors.black,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // --- Color Selector ---
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: colors.map((color) {
            final isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() => selectedColor = color);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.black
                        : Colors.grey.withOpacity(0.3),
                    width: isSelected ? 3 : 1,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // --- Quantity Selector ---
  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _circleButton(Icons.remove, () {
              if (quantity > 1) setState(() => quantity--);
            }),
            const SizedBox(width: 20),
            Text(
              '$quantity',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 20),
            _circleButton(Icons.add, () {
              setState(() => quantity++);
            }),
          ],
        ),
      ],
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

  // --- Description Section ---
  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.product.description ??
              'No description available for this product.',
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
      ],
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
