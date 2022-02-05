import 'dart:async';

import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Screens/dashboard/dashboard.dart';
import 'package:aioft_bpo/Screens/fleet/components/fleet_reg_form.dart';
import 'package:aioft_bpo/Screens/fleet/drivers/fleet_drivers_screen.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/dialog_body.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/Widgets/user_count_widget.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class FleetScreen extends StatefulWidget {
  const FleetScreen({Key? key}) : super(key: key);

  static const routeName = '/fleet';

  @override
  _FleetScreenState createState() => _FleetScreenState();
}

class _FleetScreenState extends State<FleetScreen> {
  Future<Users>? _fleetUserFuture;
  final CallApi _callApi = CallApi();
  final _prefs = PreferecesServices();
  var _agentPhoneNumber;
  int? userLength;

  bool _loaded = false;
  var img = Image.network("src");
  var placeholder = AssetImage("assetName");

  @override
  void initState() {
    super.initState();

    _fleetUserFuture = _callApi.fetchUsers('/providerall');
  }

  populatesField() async {
    final newAgent = await _prefs.getData();
    setState(() {
      _agentPhoneNumber = newAgent.phoneNumber ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    populatesField();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, DashBoardScreen.routeName),
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text("All Fleet Users"),
        actions: [UserCountWidget(userLength: userLength)],
      ),
      body: FutureBuilder<Users>(
          future: _fleetUserFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              userLength = snapshot.data!.fleet!.length;
              return ListView.builder(
                  itemCount: snapshot.data!.fleet?.length,
                  itemBuilder: (context, index) {
                    final fleetUser = snapshot.data!.fleet![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 2),
                      elevation: 0.8,
                      child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FleetDriversScreen(
                                      fleet: fleetUser,
                                    ))),
                        title: Text("${fleetUser.fname}", style: kNameStyle),
                        leading: fleetUser.logo == null
                            ? const CircleAvatar(
                                child: Image(
                                    image: AssetImage(
                                        'assets/images/profile.png')),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(fleetUser.logo),
                              ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                fleetUser.femail ?? 'No email',
                                style: kCityTextStyle,
                              ),
                            ],
                          ),
                        ),
                        trailing: SizedBox(
                          height: 30,
                          width: 45,
                          child: OutlinedButton(
                            onPressed: () {
                              showAwesomeDialog(context, fleetUser);
                            },
                            child: const Icon(
                              Icons.call,
                              color: kBtnColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  AwesomeDialog showAwesomeDialog(BuildContext context, Fleet fleetUser) =>
      AwesomeDialog(
        context: context,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.NO_HEADER,
        dismissOnTouchOutside: false,
        body: DialogBodyWidget(
          dialogTitle: '${fleetUser.fname}',
        ),
        customHeader: const Icon(
          Icons.call,
          size: 45,
          semanticLabel: 'Make Call',
        ),
        btnOkText: 'Connect',
        btnOkColor: kBtnColor,
        btnOkOnPress: () {
          var data = {
            'agent_number': _agentPhoneNumber,
            'destination_number': fleetUser.fmobile,
          };
          if (_agentPhoneNumber == null) {
            message(context, 'Please Add Agent number in profile section.');
          } else if (_agentPhoneNumber.toString().length < 10) {
            message(context,
                'Agent number is less than 10. Try to add vaild number.');
          } else if (_agentPhoneNumber.toString().length > 10) {
            message(context,
                'Agent number is greater than 10. Try to add valid number');
          } else {
            CallApi().postDataIntoTataTelecomeApi(data, '/click_to_call');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                backgroundColor: kBtnColor,
                elevation: 10,
                duration: const Duration(seconds: 10),
                content: Container(
                  height: 150,
                  child: const Center(
                    child: Text(
                      'Connecting.../n/nPlease Wait For Few Second Agent Will Get a Call.',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );

            // Timer(const Duration(seconds: 5), () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => FleetRegistartion(
            //                 fleetDriver: fleed,
            //               )));
            // });
          }
        },
        btnCancelOnPress: () {},
      )..show();
}
