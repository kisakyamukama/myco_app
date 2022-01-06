import 'package:http/http.dart' as http;
import 'package:myco/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryRemoteRepository {
  static const uri = remoteUrl + '/diary';

  Future getAuthenticatedHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'access-token': '${prefs.getString(USERTOKEN)}',
    };
    return requestHeaders;
  }

  Future addJournal(var body) async {
    var headers = await getAuthenticatedHeader();
    return http.post(Uri.parse(uri), body: body, headers: headers);
  }

  Future getJournals() async {
    var headers = await getAuthenticatedHeader();
    return http.get(Uri.parse(uri), headers: headers);
  }
}
