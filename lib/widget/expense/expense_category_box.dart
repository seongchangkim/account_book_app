import 'package:flutter/material.dart';

class ExpenseCategoryBox extends StatefulWidget {
  final String currentSelectedCategory;
  final String categoryValue;
  final String text;
  final void Function(String) function;
  const ExpenseCategoryBox(
      {super.key,
      required this.currentSelectedCategory,
      required this.categoryValue,
      required this.text,
      required this.function});

  @override
  State<ExpenseCategoryBox> createState() => _ExpenseCategoryBoxState();
}

class _ExpenseCategoryBoxState extends State<ExpenseCategoryBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return GestureDetector(
      onTap: () {
        print("value : ${widget.categoryValue}");
        widget.function(widget.categoryValue);
        print("select : ${widget.currentSelectedCategory}");
      },
      child: Container(
        width: width * 0.2,
        height: height * 0.11,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(
                color: widget.currentSelectedCategory == widget.categoryValue
                    ? Colors.blueAccent
                    : Colors.black26),
            color: Colors.white),
        child: Center(
          child: Text(widget.text,
              style: TextStyle(
                  fontSize: 10,
                  color: widget.currentSelectedCategory == widget.categoryValue
                      ? Colors.blueAccent
                      : Colors.black26)),
        ),
      ),
    );
  }
}
