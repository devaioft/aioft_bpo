import 'dart:async';
import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Screens/RegistrationForm/provider_reg_form.dart';
import 'package:aioft_bpo/Screens/callLogs/call_history.dart';
import 'package:aioft_bpo/Screens/dashboard.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/dialog_body.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/Widgets/provider_namewidget.dart';
import 'package:aioft_bpo/Widgets/user_count_widget.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({Key? key}) : super(key: key);

  static const routeName = '/provider';

  @override
  _ProviderScreenState createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  Future<Users>? _providerFuture;
  final CallApi _callApi = CallApi();
  final _prefs = PreferecesServices();
  var _agentPhoneNumber;
  int? providerUserLength;

  @override
  void initState() {
    super.initState();

    _providerFuture = _callApi.fetchUsers('/providerall');
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
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DashBoardScreen())),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Providers"),
        actions: [
          // IconButton(
          //   // onPressed: ()=>Navigator.restorablePushNamed(context, CallHistory.routeName),
          //   icon: const Icon(
          //     Icons.history_sharp,

          //     size: 24,
          //   ),
          // ),
          UserCountWidget(userLength: providerUserLength)
        ],
      ),
      body: FutureBuilder<Users>(
          future: _providerFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              providerUserLength = snapshot.data!.providers!.length;

              return ListView.builder(
                  itemCount: snapshot.data!.providers!.length,
                  itemBuilder: (context, index) {
                    final providerUser = snapshot.data!.providers![index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 2),
                      elevation: 0.8,
                      child: ListTile(
                        title: ProviderNameWidget(user: providerUser),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  providerUser.id.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                  ),
                                ),
                              ),
                              Text(
                                providerUser.status ?? 'No status',
                                style: const TextStyle(
                                  color: kBtnColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
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
                                                ProviderRegistartion(
                                                  provider: providerUser,
                                                )));
                                  },
                                  icon: const Icon(Icons.visibility_sharp)),
                              SizedBox(
                                height: 30,
                                width: 45,
                                child: OutlinedButton(
                                  onPressed: () {
                                    showAwesomeDialog(context, providerUser);
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
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  AwesomeDialog showAwesomeDialog(BuildContext context, Provider provider) =>
      AwesomeDialog(
        context: context,
        animType: AnimType.TOPSLIDE,
        dialogType: DialogType.SUCCES,
        dismissOnTouchOutside: false,
        customHeader: const Icon(
          Icons.call,
          size: 45,
          semanticLabel: 'Make Call',
        ),
        body: DialogBodyWidget(
          dialogTitle: '${provider.firstName} ${provider.lastName}',
        ),
        btnOkText: 'Connect',
        btnOkColor: kBtnColor,
        btnOkOnPress: () {
          var data = {
            'agent_number': _agentPhoneNumber,
            'destination_number': provider.mobile,
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
                elevation: 10,
                backgroundColor: kBtnColor,
                duration: const Duration(seconds: 5),
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

            Timer(const Duration(seconds: 5), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProviderRegistartion(
                            provider: provider,
                          )));
            });
          }
        },
        btnCancelOnPress: () {},
      )..show();
}
