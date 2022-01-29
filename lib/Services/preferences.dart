import 'package:shared_preferences/shared_preferences.dart';

class PreferecesServices {
  setData(Profile profile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('phone', profile.phoneNumber!);
    await prefs.setString('link', profile.link!);
  }

  Future<Profile> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString('phone');
    final regLink = prefs.getString('link');

    return Profile(phoneNumber: phoneNumber,link: regLink);
  }
}

class Profile {
  String? phoneNumber;
  String? link;
  Profile({this.phoneNumber,this.link});
}
