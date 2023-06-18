import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class UserInputForm extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final String inputType;
  final bool isWriteInputForm;
  final bool isMoveNextCursor;

  const UserInputForm(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.inputType,
      this.isWriteInputForm = false,
      this.isMoveNextCursor = true});

  @override
  State<UserInputForm> createState() => _UserInputFormState();
}

class _UserInputFormState extends State<UserInputForm> {
  MaskTextInputFormatter telFormatter = MaskTextInputFormatter(
      mask: "###-####-####",
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  // late FocusNode myFocusNode;

  // @override
  // void initState() {
  //   super.initState();

  //   myFocusNode = FocusNode();
  // }

  // @override
  // void dispose() {
  //   // Clean up the focus node when the Form is disposed.
  //   myFocusNode.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        readOnly: widget.isWriteInputForm ? true : false,
        inputFormatters: widget.inputType == "tel" ? [telFormatter] : [],
        controller: widget.controller,
        textInputAction: widget.isMoveNextCursor
            ? TextInputAction.next
            : TextInputAction.done,
        decoration: InputDecoration(labelText: widget.labelText),
        obscureText: widget.inputType == "password" ? true : false,
        validator: (text) {
          String? emptyValidatorStr = isInputTextEmpty(text, widget.labelText);

          if (emptyValidatorStr != null) {
            return emptyValidatorStr;
          }

          if (widget.inputType == "email") {
            return !text!.trim().contains("@") ? "이메일 형식을 맞게 입력하세요!" : null;
          } else if (widget.inputType == "password") {
            return text!.length < 8 ? "비밀번호를 8자 이상 입력하세요." : null;
          } else if (widget.inputType == "tel") {
            String pattern = '01[0|1|6|8|9]{1}-[0-9]{3,4}-[0-9]{4}';
            RegExp regExp = RegExp(pattern);

            return !regExp.hasMatch(text!) ? "전화번호 형식에 맞게 입력하세요." : null;
          }
        },
      ),
    );
  }
}

String? isInputTextEmpty(String? inputText, String labelText) {
  return inputText!.trim().isEmpty ? "$labelText을 입력하세요!" : null;
}
