import 'package:flutter/material.dart';

class MorePageContainer extends StatelessWidget {
  final String text;
  const MorePageContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: const TextStyle(fontSize: 12)),
            const Icon(Icons.arrow_forward_ios, size: 12)
          ],
        ),
      ),
    );
  }
}
