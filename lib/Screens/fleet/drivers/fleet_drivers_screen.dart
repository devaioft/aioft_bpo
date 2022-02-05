import 'dart:async';

import 'package:aioft_bpo/Models/fleet_driver_model.dart';
import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Screens/fleet/components/fleet_reg_form.dart';
import 'package:aioft_bpo/Screens/fleet/fleet_screen.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/dialog_body.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/Widgets/user_count_widget.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class FleetDriversScreen extends StatefulWidget {
  const FleetDriversScreen({Key? key, this.fleet}) : super(key: key);

  static const routeName = '/fleetdrivers';

  final Fleet? fleet;
  @override
  _FleetDriversScreenState createState() => _FleetDriversScreenState();
}

class _FleetDriversScreenState extends State<FleetDriversScreen> {
  Future<FleetDrivers>? _fleetDriverFuture;
  final CallApi _callApi = CallApi();
  final _prefs = PreferecesServices();
  var _agentPhoneNumber;
  int? userLength;

  @override
  void initState() {
    super.initState();
    print(widget.fleet!.fid.toString());
    _fleetDriverFuture =
        _callApi.fetchFleetDrivers('/fleet/', widget.fleet!.fid.toString());
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
                Navigator.pushNamed(context, FleetScreen.routeName),
            icon: const Icon(Icons.arrow_back_ios)),
        title: Text(widget.fleet!.fname!),
        actions: [UserCountWidget(userLength: userLength)],
      ),
      body: FutureBuilder<FleetDrivers>(
          future: _fleetDriverFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.fleet!.length < 0) {
                return Center(child: Text("No Data"));
              } else {
                userLength = snapshot.data!.fleet!.length;
                return ListView.builder(
                    itemCount: snapshot.data!.fleet?.length,
                    itemBuilder: (context, index) {
                      final fleetDriver = snapshot.data!.fleet![index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 2),
                        elevation: 0.8,
                        child: ListTile(
                          leading: fleetDriver.avatar == null
                              ? const CircleAvatar(
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/profile.png')),
                                )
                              : CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(fleetDriver.avatar!),
                                ),
                          title: Text(
                              "${fleetDriver.firstName} ${fleetDriver.lastName}",
                              style: kNameStyle),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  fleetDriver.address ?? 'No Address',
                                  style: kCityTextStyle,
                                ),
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FleetRegistartion(fleetDriver: fleetDriver),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.visibility_sharp)),
                                SizedBox(
                                  height: 30,
                                  width: 45,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showAwesomeDialog(context, fleetDriver);
                                    },
                                    child: const Icon(
                                      Icons.call,
                                      color: kBtnColor,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  AwesomeDialog showAwesomeDialog(
          BuildContext context, FleetDriver fleetDriver) =>
      AwesomeDialog(
        context: context,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.NO_HEADER,
        dismissOnTouchOutside: false,
        body: DialogBodyWidget(
          dialogTitle: '${fleetDriver.firstName} ${fleetDriver.lastName}',
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
            'destination_number': fleetDriver.mobile,
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
                      'Connecting...\n\nPlease Wait For Few Second Agent Will Get a Call.',
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
            //                 fleet: fleetUser,
            //               )));
            // });
          }
        },
        btnCancelOnPress: () {},
      )..show();
}
