import 'dart:async';
import 'dart:developer';

import 'package:account_book_app/appbar/text_center_appbar.dart';
import 'package:account_book_app/dialog/confirm_dialog.dart';
import 'package:account_book_app/dialog/expense/expense_category_select_dialog.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:account_book_app/widget/expense/expense_input_btn.dart';
import 'package:account_book_app/widget/expense/expense_input_form.dart';
import 'package:account_book_app/widget/expense/expense_status_box.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:account_book_app/api/expense/expense_api.dart';
import 'package:intl/intl.dart';

class ExpenseAddOrEditPage extends StatefulWidget {
  final bool isEditing;
  final int expenseId;
  const ExpenseAddOrEditPage(
      {super.key, this.isEditing = false, this.expenseId = 0});

  @override
  State<ExpenseAddOrEditPage> createState() => _ExpenseAddOrEditPageState();
}

class _ExpenseAddOrEditPageState extends State<ExpenseAddOrEditPage> {
  final expenseAddForm = GlobalKey<FormState>();
  // 현재 날짜
  DateTime date = DateTime.now();
  // 금액
  TextEditingController _expenseController = TextEditingController();
  // 내용
  TextEditingController _contentController = TextEditingController();
  // 지출 상태 인덱스
  String selectedStatus = "EXPENSE";
  // 선택한 분류
  String selectedCategory = "";

  // 회원 상태 저장소
  final _userController = Get.put(UserStore());
  late Future expenseFuture;

  @override
  void initState() {
    expenseFuture = _onFirst();
    super.initState();
  }

  Future<bool> _onFirst() async {
    if (widget.isEditing) {
      var res = await getExpenseById(widget.expenseId.toString());

      _expenseController.text = res["expensePrice"].toString();
      _contentController.text = res["content"];
      date = DateFormat("yyyy-MM-dd").parse(res["date"]);
      selectedStatus = res["status"];
      selectedCategory = res["category"];
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;

    return Scaffold(
      appBar: TextCenterAppBar(
          appBar: AppBar(),
          title: "가계부",
          func: () => Navigator.pop(context, true)),
      body: SafeArea(
          child: Container(
        width: width,
        padding: EdgeInsets.symmetric(horizontal: width * 0.1),
        child: FutureBuilder(
          future: expenseFuture,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Form(
                  key: expenseAddForm,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            ExpenseStatusBox(
                              currentSelectedStatus: selectedStatus,
                              selectedStatus: "INCOME",
                              margin: const EdgeInsets.fromLTRB(0, 20, 5, 20),
                              focusColor: Colors.blueAccent,
                              text: "수입",
                              function: () => setState(() {
                                selectedStatus = "INCOME";
                              }),
                            ),
                            ExpenseStatusBox(
                              currentSelectedStatus: selectedStatus,
                              selectedStatus: "EXPENSE",
                              margin: const EdgeInsets.fromLTRB(5, 20, 0, 20),
                              focusColor: Colors.redAccent,
                              text: "지출",
                              function: () => setState(() {
                                selectedStatus = "EXPENSE";
                              }),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    "날짜",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black38),
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () async {
                                    final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: date,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2999));

                                    if (selectedDate != null) {
                                      setState(() {
                                        date = selectedDate;
                                      });
                                    }

                                    print(selectedDate.runtimeType);
                                  },
                                  child: Text(
                                    " ${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      ExpenseInputForm(labelText: "금액", textController: _expenseController),
                      ExpenseInputForm(labelText: "내용", textController: _contentController),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            const Expanded(
                                flex: 1,
                                child: Center(
                                  child: Text(
                                    "분류",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.black38),
                                  ),
                                )),
                            Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ExpenseCategorySelectDialog(
                                              currentSelectedCategory:
                                                  selectedCategory,
                                              function: (String value) {
                                                setState(() {
                                                  selectedCategory = value;
                                                });
                                              });
                                        });
                                  },
                                  child: Text(
                                    " ${getExpenseCategoryKey(selectedCategory)}",
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      if (!widget.isEditing)
                        GestureDetector(
                          onTap: () async {
                            if (expenseAddForm.currentState!.validate()) {
                              var res = await addExpense(
                                  _userController.userId,
                                  DateFormat('yyyy-MM-dd')
                                      .format(date)
                                      .toString(),
                                  _contentController.text,
                                  _expenseController.text,
                                  selectedStatus,
                                  selectedCategory);

                              if (res["success"]) {
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          child: const ExpenseInputBtn(color: Colors.blueAccent, btnText: "추가", margin: EdgeInsets.only(top: 20))
                          // Container(
                          //   height: 50,
                          //   margin: const EdgeInsets.only(top: 20),
                          //   decoration: const BoxDecoration(
                          //       borderRadius:
                          //           BorderRadius.all(Radius.circular(10)),
                          //       color: Colors.blueAccent),
                          //   child: const Center(
                          //     child: Text(
                          //       "추가",
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //   ),
                          // ),
                        )
                      else if (widget.isEditing)
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (expenseAddForm.currentState!
                                        .validate()) {
                                      var res = await editExpense(
                                          widget.expenseId.toString(),
                                          DateFormat('yyyy-MM-dd')
                                              .format(date)
                                              .toString(),
                                          _contentController.text,
                                          _expenseController.text,
                                          selectedStatus,
                                          selectedCategory);

                                      if (res["success"]) {
                                        var typeConverting =
                                            DateTime.fromMillisecondsSinceEpoch(
                                                res["date"]);

                                        setState(() {
                                          _contentController.text =
                                              res["content"];
                                          _expenseController.text =
                                              res["expensePrice"].toString();
                                          selectedStatus = res["status"];
                                          selectedCategory = res["category"];
                                          date = DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  res["date"]);
                                        });

                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ConfirmDialog(
                                                  title: "지출 항목 수정",
                                                  content: "해당 지출 항목을 수정했습니다.",
                                                  func: () =>
                                                      Navigator.pop(context));
                                            });
                                      }
                                    }
                                  },
                                  child: const ExpenseInputBtn(color: Colors.blueAccent, btnText: "수정", margin: EdgeInsets.only(top: 20, right: 5),)
                                  // Container(
                                  //   height: 50,
                                  //   margin: const EdgeInsets.only(top: 20, right: 5),
                                  //   decoration: const BoxDecoration(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10)),
                                  //       color: Colors.blueAccent),
                                  //   child: const Center(
                                  //     child: Text(
                                  //       "수정",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ),
                                  //   ),
                                  // ),
                                )),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (expenseAddForm.currentState!
                                        .validate()) {
                                      var res = await deleteExpense(
                                          widget.expenseId.toString());

                                      if (res['success']) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ConfirmDialog(
                                                  title: "지출 항목 삭제",
                                                  content: "해당 지출 항목 삭제되었습니다.",
                                                  func: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(
                                                        context, true);
                                                  });
                                            });
                                      }
                                    }
                                  },
                                  child: const ExpenseInputBtn(color: Colors.redAccent, btnText: "삭제", margin: EdgeInsets.only(top: 20, left: 5))
                                  // Container(
                                  //   height: 50,
                                  //   margin: const EdgeInsets.only(top: 20, left: 5),
                                  //   decoration: const BoxDecoration(
                                  //       borderRadius: BorderRadius.all(
                                  //           Radius.circular(10)),
                                  //       color: Colors.redAccent),
                                  //   child: const Center(
                                  //     child: Text(
                                  //       "삭제",
                                  //       style: TextStyle(color: Colors.white),
                                  //     ),
                                  //   ),
                                  // ),
                                )),
                          ],
                        )
                    ],
                  ));
            }
          },
        ),
      )),
    );
  }

  void selectCategory(String value) {
    setState(() {
      selectedCategory = value;
    });
  }
}

// 지출 카테고리에 대한 키값
String getExpenseCategoryKey(String categoryValue) {
  if (categoryValue == "FIX_EXPENSE") {
    return "고정비";
  } else if (categoryValue == "LIVING_EXPENSE") {
    return "생활비";
  } else if (categoryValue == "CAR_EXPENSE") {
    return "차량 유지비";
  } else if (categoryValue == "SAVING_EXPENSE") {
    return "저축비";
  } else if (categoryValue == "INCOME_EXPENSE") {
    return "월급";
  } else if (categoryValue == "INVEST_EXPENSE") {
    return "투자비";
  } else {
    return "기타";
  }
}
