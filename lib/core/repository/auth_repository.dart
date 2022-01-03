
import 'repository.dart';


class AuthRepository {
  static Future login(
      {required String username, required String password}) async {
    var body = {'username': username, 'password': password};
   
    return await Repository.login(body);
  }
}
