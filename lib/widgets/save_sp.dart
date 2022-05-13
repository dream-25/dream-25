import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

void saveSP(String key, String value) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
}
