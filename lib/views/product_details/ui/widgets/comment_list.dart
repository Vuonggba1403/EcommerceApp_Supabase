import 'package:flutter/material.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // Tắt cuộn độc lập của ListView (dùng khi đặt trong widget cuộn khác)
      physics: const NeverScrollableScrollPhysics(),
      // Mỗi phần tử trong danh sách là 1 UserComment
      itemBuilder: (context, index) => const UserComment(),
      // Đường kẻ mờ giữa các comment
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: 5,
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Ảnh đại diện người dùng
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/user_images.png'),
        ),
        const SizedBox(width: 10),
        // Nội dung comment (bên phải avatar)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Khung chứa tên và bình luận (giống bong bóng comment Facebook)
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "This is the user's comment. It can be a few lines long.",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              // Hàng chứa các hành động nhỏ như "Like", "Reply", "Time"
              Row(
                children: [
                  Text(
                    "Like",
                    style: TextStyle(color: Colors.blue, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "Reply",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "2h",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
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
