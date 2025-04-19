import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thuc_tap_1/pages/payment/chat_ai_page.dart';

class ShimmerButtonDemo extends StatelessWidget {
  const ShimmerButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.red),
        ),
        elevation: 2,
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      },
      child: Shimmer.fromColors(
        baseColor: Colors.red,
        highlightColor: Colors.yellow,
        child: const Text(
          "Chat AI",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black, 
          ),
        ),
      ),
    );
  }
}
