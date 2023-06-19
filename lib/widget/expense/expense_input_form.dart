import 'package:flutter/material.dart';
import 'package:account_book_app/widget/user/user_input_form.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ExpenseInputForm extends StatelessWidget {
  final String labelText;
  final TextEditingController textController;
  
  ExpenseInputForm(
      {super.key, required this.labelText, required this.textController});

  // 비용 입력 형식 지정
  final _expenseFormatter = MaskTextInputFormatter(
      mask: "############",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
      
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  labelText,
                  style: const TextStyle(fontSize: 13, color: Colors.black38),
                ),
              )),
          Expanded(
              flex: 3,
              child: Container(
                height: 25,
                child: TextFormField(
                    style: const TextStyle(fontSize: 13),
                    controller: textController,
                    inputFormatters: labelText == "금액" ? [_expenseFormatter] : [],
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        labelText: "",
                        border: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: Colors.blueAccent, width: 1.0),
                        ),
                        isCollapsed: true,
                        contentPadding:
                            const EdgeInsets.all(5),
                        isDense: true),
                    validator: (text) {
                      String? emptyValidatorStr = isInputTextEmpty(text, "내용");

                      if (emptyValidatorStr != null) {
                        return emptyValidatorStr;
                      }
                    }),
              ))
        ],
      ),
    );
  }
}
