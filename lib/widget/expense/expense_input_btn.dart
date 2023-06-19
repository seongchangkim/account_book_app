import 'package:flutter/material.dart';

class ExpenseInputBtn extends StatelessWidget {
  final Color color;
  final String btnText;
  final EdgeInsetsGeometry margin;
  const ExpenseInputBtn(
      {super.key, required this.color, required this.btnText, required this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: margin,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: color),
      child: Center(
        child: Text(
          btnText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13
          ),
        ),
      ),
    );
  }
}
