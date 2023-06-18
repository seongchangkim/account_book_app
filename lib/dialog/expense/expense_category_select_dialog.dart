import 'package:account_book_app/widget/expense/expense_category_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseCategorySelectDialog extends StatefulWidget {
  final String currentSelectedCategory;
  final void Function(String) function;
  const ExpenseCategorySelectDialog(
      {super.key,
      required this.currentSelectedCategory,
      required this.function});

  @override
  State<ExpenseCategorySelectDialog> createState() =>
      _ExpenseCategorySelectDialogState();
}

class _ExpenseCategorySelectDialogState
    extends State<ExpenseCategorySelectDialog> {
  String selectedCategory = "";

  @override
  void initState() {
    selectedCategory = widget.currentSelectedCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Dialog(
      alignment: Alignment.center,
      child: Container(
        height: height * 0.5,
        width: width,
        padding: const EdgeInsets.only(left: 10, top: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const FaIcon(FontAwesomeIcons.xmark),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "FIX_EXPENSE",
                  text: "고정비",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "LIVING_EXPENSE",
                  text: "생활비",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "CAR_EXPENSE",
                  text: "차량 유지비",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "SAVING_EXPENSE",
                  text: "저축비",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "INCOME_EXPENSE",
                  text: "월급",
                  function: (String value) {
                    print("value : ${value}");
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "INVEST_EXPENSE",
                  text: "투자비",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpenseCategoryBox(
                  currentSelectedCategory: selectedCategory,
                  categoryValue: "OTHERS",
                  text: "기타",
                  function: (String value) {
                    widget.function(value);
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
            ],
          ),
        ]),
      ),
    );
  }
}
