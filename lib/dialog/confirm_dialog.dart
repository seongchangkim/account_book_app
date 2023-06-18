import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final void Function() func;

  const ConfirmDialog(
      {super.key,
      required this.title,
      required this.content,
      required this.func});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Dialog(
        alignment: Alignment.center,
        child: Container(
          height: height * 0.25,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Column(
            children: [
              Container(
                  width: width,
                  // decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: Colors.black38))),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 40,
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )),
              Container(
                  height: 90,
                  child: Center(
                    child: Text(
                      content,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  print("click");
                  func();
                },
                child: Container(
                    width: width,
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black38))),
                    height: 30,
                    child: const Center(
                      child: Text(
                        "확인",
                        style: TextStyle(fontSize: 15),
                      ),
                    )),
              )
            ],
          ),
        ));
  }
}
