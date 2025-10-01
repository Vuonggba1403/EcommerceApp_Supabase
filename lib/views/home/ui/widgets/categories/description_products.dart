import 'package:e_commerce_app_supabase/common/custom_backbutton.dart';
import 'package:flutter/material.dart';

class ProductDescriptionScreen extends StatefulWidget {
  const ProductDescriptionScreen({super.key, required this.productData});

  final Map<String, dynamic> productData;

  @override
  State<ProductDescriptionScreen> createState() =>
      _ProductDescriptionScreenState();
}

class _ProductDescriptionScreenState extends State<ProductDescriptionScreen> {
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

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImageSection(size),
                    _buildProductDetails(size),
                  ],
                ),
              ),
            ),
            _buildBottomSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(Size size) {
    return Container(
      height: size.height * 0.5,
      width: double.infinity,
      color: Colors.grey[100],
      child: Stack(
        children: [
          Center(
            child: Image.network(
              widget.productData['image'] ?? 'https://via.placeholder.com/300',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: Icon(Icons.image, size: 100, color: Colors.grey),
                );
              },
            ),
          ),
          Positioned(top: 20, left: 20, child: CustomBackbutton()),
          Positioned(
            top: 20,
            right: 20,
            child: Icon(Icons.favorite_border, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(Size size) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.productData['name'] ?? "Men's Herrington Jacket",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '\$${widget.productData['price'] ?? '148'}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(height: 20),
          _buildSizeSelector(),
          SizedBox(height: 20),
          _buildColorSelector(),
          SizedBox(height: 20),
          _buildQuantitySelector(),
          SizedBox(height: 20),
          _buildDescription(),
          SizedBox(height: 20),
          _buildShippingInfo(),
          SizedBox(height: 20),
          _buildReviews(),
        ],
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          children: sizes.map((size) {
            bool isSelected = selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Color',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          children: colors.map((color) {
            bool isSelected = selectedColor == color;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedColor = color;
                });
              },
              child: Container(
                margin: EdgeInsets.only(right: 10),
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

  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                if (quantity > 1) {
                  setState(() {
                    quantity--;
                  });
                }
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove, color: Colors.white),
              ),
            ),
            SizedBox(width: 20),
            Text(
              quantity.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 20),
            GestureDetector(
              onTap: () {
                setState(() {
                  quantity++;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text(
          widget.productData['description'] ??
              'Built for life and styled for the city, this technical fleece hoodie will keep you comfortable during your busy day.',
          style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.5),
        ),
      ],
    );
  }

  Widget _buildShippingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shipping & Returns',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Text(
          'Free standard shipping over \$75.00 returns',
          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
        ),
      ],
    );
  }

  Widget _buildReviews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Reviews',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              '4.5 Ratings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < 4 ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                );
              }),
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          '${widget.productData['reviewCount'] ?? '279'} Reviews',
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '\$${widget.productData['price'] ?? '148'}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Add to cart functionality
                _addToCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
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
    // Implement add to cart functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Added to cart: ${widget.productData['name']} (Size: $selectedSize, Qty: $quantity)',
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
