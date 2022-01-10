
import 'package:aioft_bpo/Models/driver_model.dart';
import 'package:aioft_bpo/Screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static const routName = '/';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String _mobileNumber = '';

  @override
  void initState() {
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber)!;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
    });
  }

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text('Running on: $_mobileNumber\n'),],
        ),
      ),
    );
  }
}



Future<void> bottomSheet(BuildContext context, Drivers drivers) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetButton(
                btnTitle: 'Connect ${drivers.firstName}',
                primaryColor: Colors.green,
                onPressed: () => {
                  // showAwesomeDialog(context),
                },
              ),
              BottomSheetButton(
                btnTitle: 'Cancel',
                primaryColor: Colors.greenAccent,
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
        );
      },
    );
  }