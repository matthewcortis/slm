import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _kRole = 'role';
  static const _kToken = 'token';

  static Future<void> save(String role, String userid) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(_kRole, role);
    await p.setString('userid', userid);
  }

  static Future<void> clear() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_kRole);
    await p.remove(_kToken);
    await p.remove('userid');
  }
}
