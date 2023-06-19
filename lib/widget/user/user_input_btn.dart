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
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: Colors.lime,
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: Center(
          child: Text(widget.btnText, style: const TextStyle(color: Colors.white),),
        )
      );
  }
}
