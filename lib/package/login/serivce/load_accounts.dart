// import 'dart:convert';
// import 'package:flutter/services.dart';
// import '../../model/account_model.dart';

// class AccountService {
//   static Future<List<AccountModel>> loadAccounts() async {
//     final jsonString = await rootBundle.loadString('assets/data/accounts.json');
//     final data = json.decode(jsonString);
//     final List accounts = data['accounts'];

//     return accounts.map((e) => AccountModel.fromJson(e)).toList();
//   }


//   static Future<AccountModel?> login(String username, String password) async {
//     final list = await loadAccounts();

//     try {
//       return list.firstWhere(
//         (acc) => acc.taikhoan == username && acc.matkhau == password,
//       );
//     } catch (_) {
//       return null;
//     }
//   }
// }
