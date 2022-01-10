import 'package:shared_preferences/shared_preferences.dart';

class PreferecesServices {
  setData(Settings setting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('phone', setting.phoneNumber!);
  }

  Future<Settings> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phone');
    return Settings(phoneNumber: phoneNumber);
  }
}

class Settings {
  String? phoneNumber;
  Settings({this.phoneNumber});
}
