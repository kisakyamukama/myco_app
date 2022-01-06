import 'package:http/http.dart' as http;
import 'package:myco/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

String USERTOKEN = 'userToken';

class Repository {
  static const String uri = remoteUrl;
      // 'http://192.168.43.147:8080/api'; //'https://sigt-beth-api.herokuapp.com/api';

  static Future login(var body) async {
    return await http.post(Uri.parse(uri + '/auth/signin'), body: body);
  }

  static Future getLessons() async {
    var headers = await getHeaders();
    return await http.get(Uri.parse(uri + '/lessons'), headers: headers);
  }

  // headers
  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {
      'access-token': prefs.getString(USERTOKEN),
    };
    return headers;
  }
}
