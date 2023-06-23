import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String content;

  const ErrorDialog({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Dialog(
        alignment: Alignment.center,
        child: Container(
          height: height * 0.29,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))
          ),
          child: Column(
          children: [
            Container(
              width: width,
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 40,
              child: const Center(
                child: Text(
                  "오류",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ) 
            ),
            Container(
              height: 90,
              child: Center(
                child: Text(
                  content,
                  style:
                      const TextStyle(fontSize: 14),
                ),
              )
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: width,
                padding: const EdgeInsets.only(top: 10),
                decoration: const BoxDecoration(border: Border(top: BorderSide(width: 1, color: Colors.black38))),
                height: 40,
                child: const Center(
                  child: Text(
                    "확인",
                    style:
                        TextStyle(fontSize: 15),
                  ),
                )
              ),
            )
          ],
        ),
      )
    );
  }
}
