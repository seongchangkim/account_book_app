import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:account_book_app/global/env/env.dart';

const BASE_URL = Env.baseUrl;

// 지출 또는 수입 항목 생성
Future<dynamic> addExpense(String userId, String date, String content,
    String expense, String status, String category) async {
  var params = {
    "userId": userId,
    "date": date,
    "content": content,
    "expense": expense,
    "status": status,
    "category": category.isEmpty ? "OTHERS" : category
  };

  Uri url = Uri.parse("${BASE_URL}/api/expense");
  var res = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(params));

  return json.decode(res.body);
}

// 날짜별 지출 또는 수입 항목 목록 불러오기
Future<dynamic> getExpenseListByDate(
  String userId, String date, String? lastExpenseId) async {
  var params = {"userId": userId, "date": date, "lastExpenseId": lastExpenseId};

  Uri url = Uri.parse("${BASE_URL}/api/expense/list");
  var res = await http.post(url,
      headers: {
        "Content-Type": "application/json",
      },
      encoding: Encoding.getByName('utf-8'),
      body: json.encode(params));

  return json.decode(res.body);
}

// 지출 또는 수입 항목 상세보기
Future<dynamic> getExpenseById(String expenseId) async {

  Uri url = Uri.parse("${BASE_URL}/api/expense/$expenseId");
  var res = await http.get(url, headers: {
    "Content-Type": "application/json",
  });

  return json.decode(res.body);
}

// 지출 또는 수입 항목 수정
Future<dynamic> editExpense(String expenseId, String date, String content, String expense, String status, String category) async {

  var params = {
    "date": date,
    "content": content,
    "expense": expense,
    "status": status,
    "category": category
  };

  Uri url = Uri.parse("${BASE_URL}/api/expense/$expenseId");
  var res = await http.patch(url, 
    headers: {
      "Content-Type": "application/json",
    },
    encoding: Encoding.getByName('utf-8'),
    body: json.encode(params));

  print("res : ${res.body}");
  return json.decode(res.body);
}

// 지출 또는 수입 항목 삭제
Future<dynamic> deleteExpense(String expenseId) async {

  Uri url = Uri.parse("${BASE_URL}/api/expense/$expenseId");
  var res = await http.delete(url, 
    headers: {
      "Content-Type": "application/json",
    },
    encoding: Encoding.getByName('utf-8'));

  print("res : ${res.body}");
  return json.decode(res.body);
}