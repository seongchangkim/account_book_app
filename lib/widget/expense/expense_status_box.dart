import 'package:flutter/material.dart';

class ExpenseStatusBox extends StatefulWidget {
  final String currentSelectedStatus;
  final String selectedStatus;
  final EdgeInsetsGeometry margin;
  final Color focusColor;
  final String text;
  final void Function() function;

  const ExpenseStatusBox(
      {super.key,
      required this.currentSelectedStatus,
      required this.selectedStatus,
      required this.margin,
      required this.focusColor,
      required this.text,
      required this.function});

  @override
  State<ExpenseStatusBox> createState() => _ExpenseStatusBoxState();
}

class _ExpenseStatusBoxState extends State<ExpenseStatusBox> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          widget.function();
          // print("selectedStatus child : ${widget.currentSelectedStatus}");
        },
        child: Container(
          margin: widget.margin,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                  color: widget.currentSelectedStatus == widget.selectedStatus
                      ? widget.focusColor
                      : Colors.black12)),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                  color: widget.currentSelectedStatus == widget.selectedStatus
                      ? widget.focusColor
                      : Colors.black12),
            ),
          ),
        ),
      ),
    );
  }
}
