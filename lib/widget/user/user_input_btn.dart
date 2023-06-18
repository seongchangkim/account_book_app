import 'package:flutter/material.dart';

class UserInputBtn extends StatefulWidget {
  final String btnText;
  const UserInputBtn({super.key, required this.btnText});

  @override
  State<UserInputBtn> createState() => _UserInputBtnState();
}

class _UserInputBtnState extends State<UserInputBtn> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;

    return Container(
        width: width,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: const BoxDecoration(color: Colors.blue),
        child: Center(
          child: Text(widget.btnText, style: const TextStyle(color: Colors.white),),
        )
      );
  }
}
