import 'package:get_storage/get_storage.dart';

class UserSession {
  UserSession._privateConstructor();
  static final UserSession _instance = UserSession._privateConstructor();
  static UserSession get instance => _instance;

  saveSession(var loggenInUserJson) {
    final box = GetStorage();
    box.write('login', loggenInUserJson);
  }

   getSession() {
    final box = GetStorage();
    return box.read('login');
  }

  removeSession() {
    final box = GetStorage();
    return box.remove('login');
  }
}
