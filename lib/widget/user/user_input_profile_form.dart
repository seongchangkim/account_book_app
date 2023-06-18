import 'package:account_book_app/widget/user/user_input_form.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserInputProfileForm extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  const UserInputProfileForm(
      {super.key, required this.label, required this.controller});

  @override
  State<UserInputProfileForm> createState() => _UserInputProfileFormState();
}

class _UserInputProfileFormState extends State<UserInputProfileForm> {
  final _telMaskFormatter = MaskTextInputFormatter(
      mask: "###-####-####",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.label,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(156, 163, 175, 1)),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(156, 163, 175, 1)))),
            inputFormatters: widget.label == "전화번호" ? [_telMaskFormatter] : [],
            controller: widget.controller,
            validator: (text){
              String? emptyValidatorStr = isInputTextEmpty(text, widget.label);

              if (emptyValidatorStr != null) {
                return emptyValidatorStr;
              }

              if (widget.label == "전화번호") {
                String pattern = '01[0|1|6|8|9]{1}-[0-9]{3,4}-[0-9]{4}';
                RegExp regExp = RegExp(pattern);

                return !regExp.hasMatch(text!) ? "전화번호 형식에 맞게 입력하세요." : null;
              }
            },
          ),
        )
      ]),
    );
  }
}
