import 'package:shared_preferences/shared_preferences.dart';

class PreferecesServices {
  setData(Profile setting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('phone', setting.phoneNumber!);
  }

  Future<Profile> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phone');
    return Profile(phoneNumber: phoneNumber);
  }
}

class Profile {
  String? phoneNumber;
  Profile({this.phoneNumber});
}
