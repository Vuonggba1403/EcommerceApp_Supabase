// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app_supabase/core/components/custom_circle_proIndicator.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:e_commerce_app_supabase/core/models/product_model/product_model.dart';
import 'package:intl/intl.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({Key? key, required this.productModel}) : super(key: key);

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // 🔹 Lắng nghe realtime bảng "comments_table" trong Supabase
      stream: Supabase.instance.client
          .from("comments_table")
          .stream(primaryKey: ['id'])
          // 🔹 Lọc chỉ lấy comment của sản phẩm hiện tại
          .eq("for_product", productModel.productId!)
          // 🔹 Sắp xếp theo thời gian tạo (từ cũ đến mới)
          .order("created_at"),

      builder: (_, snapshot) {
        // Dữ liệu lấy về từ stream, có thể null
        List<Map<String, dynamic>>? data = snapshot.data;
        // 🟢 Khi stream đang trong trạng thái "đang kết nối"
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircleProgIndicator());
        }
        // 🟡 Khi đã kết nối nhưng chưa có dữ liệu
        else if (snapshot.hasData) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) =>
                UserComment(commentData: data?[index]),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            // 🔹 Nếu có data → dùng độ dài thật, nếu null → 0
            itemCount: data?.length ?? 0,
          );
          //Không có dữ liệu
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text("No comments yet, be the first to comment!"),
          );
        }
        // 🔴 Khi xảy ra lỗi hoặc không hợp lệ
        else {
          return const Center(
            child: Text("Something went error, please try again"),
          );
        }
      },
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key, required this.commentData});
  final Map<String, dynamic>? commentData;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/user_images.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${commentData?['firstName'] ?? ''} ${commentData?['lastName'] ?? ''}"
                              .trim()
                              .isEmpty
                          ? "User Name"
                          : "${commentData?['firstName'] ?? ''} ${commentData?['lastName'] ?? ''}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 4),
                    Text(
                      commentData?['comment'] ?? 'Comment',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),
              Row(
                children: [
                  const Text(
                    "Like",
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Reply",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    commentData?['created_at'] != null
                        ? (() {
                            final createdAt = DateTime.parse(
                              commentData!['created_at'],
                            ).toLocal();
                            final now = DateTime.now();
                            if (now.day == createdAt.day &&
                                now.month == createdAt.month &&
                                now.year == createdAt.year) {
                              // Cùng ngày -> chỉ hiển thị giờ
                              return DateFormat('HH:mm').format(createdAt);
                            } else {
                              // Khác ngày -> hiển thị giờ + ngày/tháng/năm
                              return DateFormat(
                                'HH:mm - dd/MM/yyyy',
                              ).format(createdAt);
                            }
                          })()
                        : "",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
