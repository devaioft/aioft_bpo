import 'dart:async';

import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/dialog_body.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/Widgets/user_count_widget.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  static const routeName = '/users';

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  Future<Users>? _usersFuture;
  final CallApi _callApi = CallApi();
  final _prefs = PreferecesServices();
  var _agentPhoneNumber;
  int? userLength;

  @override
  void initState() {
    super.initState();

    _usersFuture = _callApi.fetchUsers('/providerall');
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
        title: const Text("Users"),
        actions: [UserCountWidget(userLength: userLength)],
      ),
      body: FutureBuilder<Users>(
          future: _usersFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              // userLength = snapshot.data!.length;

              return ListView.builder(
                  itemCount: snapshot.data!.providers!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data!.providers![index];
                    return UserCard(
                      provider: user,
                      onPressed: () => showAwesomeDialog(context, user),
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
          dialogTitle: '${provider.firstName}  ${provider.lastName}',
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

            // Timer(const Duration(seconds: 5), () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => UserRegistarationScreen(
            //               // provider: provider,
            //               )));
            // });
          }
        },
        btnCancelOnPress: () {},
      )..show();
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    this.onPressed,
    required this.provider,
  }) : super(key: key);

  final void Function()? onPressed;
  final Provider provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
      elevation: 0.8,
      child: ListTile(
        title: Text(provider.firstName! + provider.lastName!),
        subtitle: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  '',
                  style: kCityTextStyle,
                ),
              ),
              Text(""),
            ],
          ),
        ),
        trailing: OutlinedButton(
          onPressed: onPressed,

          // () {
          //   // showAwesomeDialog(context, providers, index);
          // },
          child: const Icon(Icons.call, color: kBtnColor),
        ),
      ),
    );
  }
}
