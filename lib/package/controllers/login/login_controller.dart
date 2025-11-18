import 'package:flutter/material.dart';
import '../../login/serivce/load_accounts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  bool isLoading = false;
  String? errorMessage;

  Future<String?> login(BuildContext context, String user, String pass) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    final acc = await AccountService.login(user, pass);

    isLoading = false;
    notifyListeners();

    if (acc == null) {
      errorMessage = "Sai tài khoản hoặc mật khẩu!";
      return null;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', acc.role);
    await prefs.setString('userid', acc.userid);

    switch (acc.role) {
      case "admin":
        Navigator.pushNamed(context, '/bottom-nav');
        break;
      case "staff":
        Navigator.pushNamed(context, '/bottom-nav');
        break;
      case "customer":
        Navigator.pushNamed(context, '/bottom-nav');
        break;
    }

    return acc.role;
  }


   
}
