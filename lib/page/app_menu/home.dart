import 'dart:math';

import 'package:account_book_app/api/user/user_api.dart';
import 'package:account_book_app/store/user_store.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:account_book_app/api/expense/expense_api.dart';
import 'package:account_book_app/page/expense/expense_add_or_edit_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  // 사용자 상태 저장소
  final _userController = Get.put(UserStore());
  final RefreshController _refreshController = RefreshController();
  late Future expenseListFuture;
  String userId = "";
  DateTime date = DateTime.now();
  List<dynamic> expenseList = [];
  int lastExpenseId = 0;

  @override
  void initState() {
    userId = _userController.userId;
    expenseListFuture = _onFirst(userId);
    super.initState();
  }

  Future<bool> _onFirst(String userId) async {
    var result = await getExpenseListByDate(
        userId, DateFormat('yyyy-MM-dd').format(date), null);
    print("result : ${result}");
    for (int i = 0; i < result["content"].length; i++) {
      if (i == (result["content"].length - 1)) {
        lastExpenseId = result["content"][i]["id"];
      }
      expenseList.add(result["content"][i]);
    }
    return expenseList.isNotEmpty ? true : false;
  }

  Future<void> _onLoad() async {
    var result = await getExpenseListByDate(userId,
        DateFormat('yyyy-MM-dd').format(date), lastExpenseId.toString());
    // print("result : ${result}");
    for (int i = 0; i < result["content"].length; i++) {
      if (i == (result["content"].length - 1)) {
        lastExpenseId = result["content"][i]["id"];
      }
      expenseList.add(result["content"][i]);
    }

    // setState(() {});
    _refreshController.loadComplete();
  }

  Future<void> _onRefresh() async {
    expenseList.clear();
    lastExpenseId = 0;

    setState(() {
      expenseListFuture = _onFirst(userId);
    });

    _refreshController.refreshCompleted();
  }

  Future<void> getExpenseListSelectdDate() async {
    expenseList.clear();
    lastExpenseId = 0;

    var result = await getExpenseListByDate(
        userId, DateFormat('yyyy-MM-dd').format(date), null);
    setState(() {
      print("result : ${result}");
      for (int i = 0; i < result["content"].length; i++) {
        if (i == (result["content"].length - 1)) {
          lastExpenseId = result["content"][i]["id"];
        }
        expenseList.add(result["content"][i]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double heiget = size.height;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: GestureDetector(
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

                await getExpenseListSelectdDate();
                _refreshController.refreshCompleted();
              }
            },
            child: Text(
              "${date.year}-${date.month < 10 ? "0${date.month}" : date.month}-${date.day < 10 ? "0${date.day}" : date.day}",
              style: const TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white12,
          elevation: 0),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: width,
                  height: heiget,
                  child: FutureBuilder(
                    future: expenseListFuture,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return SmartRefresher(
                            controller: _refreshController,
                            enablePullUp: true,
                            enablePullDown: true,
                            onLoading: _onLoad,
                            onRefresh: _onRefresh,
                            header: CustomHeader(
                              builder: ((BuildContext context, mode) {
                                Widget body = const CircularProgressIndicator();

                                // if(mode == RefreshStatus.idle || mode == RefreshStatus.refreshing){

                                // } else {
                                //   body = const CircularProgressIndicator();
                                // }

                                return Container(
                                  height: 55,
                                  child: Center(
                                    child: body,
                                  ),
                                );
                              }),
                            ),
                            footer: CustomFooter(
                              builder: ((context, mode) {
                                Widget body = const CircularProgressIndicator();

                                // if(mode == RefreshStatus.idle || mode == RefreshStatus.refreshing){

                                // } else {
                                //   body = const CircularProgressIndicator();
                                // }

                                return Container(
                                  height: 55,
                                  child: Center(
                                    child: body,
                                  ),
                                );
                              }),
                            ),
                            child: ListView.builder(
                                itemCount: expenseList.length,
                                itemBuilder: (context, index) {
                                  final expense = expenseList[index];

                                  return GestureDetector(
                                      onTap: () async {
                                        bool isRefresh = await Navigator.pushNamed(
                                            context, "/expenseEdit",
                                            arguments: {
                                              "expenseId": expense["id"]
                                            }) as bool;

                                        if (isRefresh) {
                                          _onRefresh();
                                        }
                                      },
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(
                                            width * 0.05, 10, width * 0.05, 0),
                                        width: width,
                                        height: heiget * 0.05,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: heiget * 0.05,
                                                child: Text(
                                                  getExpenseCategoryKey(
                                                      expense["category"]),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                height: heiget * 0.05,
                                                child: Text(
                                                  expense["content"],
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                height: heiget * 0.05,
                                                child: Text(expense["status"] ==
                                                        "INCOME"
                                                    ? "${expense["expensePrice"]}"
                                                    : "-${expense["expensePrice"]}"),
                                              ),
                                            )
                                          ],
                                        ),
                                      ));
                                }));
                      } else {
                        return const Center(
                          child: Text("데이터가 없습니다"),
                        );
                      }
                    }),
                  )))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/expenseAdd"),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
