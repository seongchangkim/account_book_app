import 'package:flutter/material.dart';

class UserInputProfileBtn extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry margin;
  final Color color;
  const UserInputProfileBtn({super.key, required this.text, required this.margin, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(40.0))
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
