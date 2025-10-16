import 'package:e_commerce_app_supabase/core/components/cache_images_view.dart';
import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:e_commerce_app_supabase/core/components/custom_textfield.dart';
import 'package:e_commerce_app_supabase/core/functions/app_colors.dart';
import 'package:e_commerce_app_supabase/core/functions/format_currency.dart';
import 'package:e_commerce_app_supabase/core/functions/naviga_with_back.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:e_commerce_app_supabase/views/auth/login/logic/cubit/authentication_cubit.dart';
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
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>
          ProductDetailsCubit()..getRates(productId: widget.product.productId!),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is AddOrUpdateRateSuccess) {
            navigateWithoutBack(context, widget);
          }
        },
        builder: (context, state) {
          ProductDetailsCubit cubit = context.read<ProductDetailsCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text(widget.product.productName ?? "Product Details"),
              backgroundColor: AppColors.primaryColor,
              elevation: 0,
              foregroundColor: AppColors.secondColor,
              actions: [
                // Icon yêu thích trong AppBar
                IconButton(
                  onPressed: () async {
                    final productId = widget.product.productId ?? "";
                    if (cubit.isFavorite) {
                      // Đang yêu thích → Xóa
                      await cubit.removeFromFavorite(productId);
                    } else {
                      // Chưa yêu thích → Thêm
                      await cubit.addToFavorite(productId);
                    }
                  },
                  icon: Icon(
                    cubit.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: cubit.isFavorite ? Colors.red : Colors.white,
                  ),
                ),
              ],
            ),
            body: state is GetRateLoading || state is AddCommentLoading
                ? CustomCircleProgIndicator()
                : SafeArea(
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
            (widget.product.productName) ?? "Unnamed Product",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "${formatCurrency(widget.product.price) ?? '0'} VND",
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("${cubit.averageRate}"),
              Icon(Icons.star, color: Colors.amber, size: 20),
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
                  initialRating: cubit.userRate.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) =>
                      Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (rating) {
                    // print(rating);
                    cubit.addOrUpdateUserRate(
                      productId: widget.product.productId!,
                      data: {
                        "rate": rating.toInt(),
                        "for_user": cubit.userID,
                        "for_product": widget.product.productId!,
                      },
                    );
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
                  controller: _commentController,
                  hintText: "Write a comment...",
                  keyboardType: TextInputType.text,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await context.read<AuthenticationCubit>().getUserData();
                  await cubit.addComment(
                    data: {
                      "comment": _commentController.text,
                      "for_user": cubit.userID,
                      "for_product": widget.product.productId,
                      "firstName":
                          context
                              .read<AuthenticationCubit>()
                              .userDataModel
                              ?.firstName ??
                          "firstName",
                      "lastName":
                          context
                              .read<AuthenticationCubit>()
                              .userDataModel
                              ?.lastName ??
                          "lastName",
                    },
                  );
                  _commentController.clear();
                },
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
          CommentsList(productModel: widget.product),
        ],
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
              // onPressed: _addToCart,
              onPressed: () {},
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

  // void _addToCart() {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(
  //         'Added to cart: ${widget.product.productName} '
  //         '(Size: $selectedSize, Qty: $quantity)',
  //       ),
  //       backgroundColor: Colors.green,
  //     ),
  //   );
  // }

  @override
  void dispose() {
    _commentController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
