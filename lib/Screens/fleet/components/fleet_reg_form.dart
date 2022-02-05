import 'package:aioft_bpo/Models/fleet_driver_model.dart';
import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Screens/fleet/drivers/fleet_drivers_screen.dart';
import 'package:aioft_bpo/Widgets/custom_text_field.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

import '../fleet_screen.dart';

class FleetRegistartion extends StatefulWidget {
  const FleetRegistartion({
    Key? key,
    this.fleetDriver,
  }) : super(key: key);
  static const routeName = "/fDetail";

  final FleetDriver? fleetDriver;

  @override
  _FleetRegistartionState createState() => _FleetRegistartionState();
}

class _FleetRegistartionState extends State<FleetRegistartion> {
  final _formKey = GlobalKey<FormState>();
  int? userid;
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final pincodeController = TextEditingController();
  String? _userTypeValue;
  final items = ['Provider', 'Fleet'];

  String msg = "This is a test message!";
  List<String> recipents = ['7779974130'];

  @override
  void initState() {
    super.initState();

    setState(() {
      userid = widget.fleetDriver!.id;
      firstNameController.text = widget.fleetDriver!.firstName ?? '';
      lastNameController.text = widget.fleetDriver!.lastName ?? '';

      addressController.text = widget.fleetDriver!.address ?? 'Bangalore';
      phoneController.text = widget.fleetDriver!.mobile ?? '';
      pincodeController.text = widget.fleetDriver!.postalCode ?? '123456';
      _userTypeValue = items[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(widget.fleetDriver!.firstName!),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("USER TYPE *"),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: 1.2, color: Colors.grey),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(8.0),
                          elevation: 3,
                          hint: const Text(
                            "Select car type",
                            style: TextStyle(color: Colors.grey),
                          ),
                          style: kDropDownMenuStyle,
                          value: _userTypeValue,
                          iconSize: 30,
                          icon: const Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.lightBlueAccent,
                          ),
                          isExpanded: true,
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) => setState(() {
                            _userTypeValue = value.toString();
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text("FIRST NAME *"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: firstNameController,
                    hintText: "your first name",
                    readMode: false,
                    keyboardType: TextInputType.text,
                    errorMessage: "Please enter first name",
                  ),
                  const SizedBox(height: 5),
                  const Text("LAST NAME *"),
                  const SizedBox(height: 5),
                  CustomTextFormField(
                    controller: lastNameController,
                    hintText: "your last name",
                    readMode: false,
                    keyboardType: TextInputType.text,
                    errorMessage: "Please enter last name",
                  ),
                  const SizedBox(height: 5),
                  const Text("PHONE NUMBER *"),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: phoneController,
                    hintText: "phone no",
                    readMode: false,
                    keyboardType: TextInputType.phone,
                    errorMessage: "Please Enter the last name",
                  ),
                  const SizedBox(height: 5),
                  const Text("FULL ADDRESS *"),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: addressController,
                    readMode: false,
                    hintText: "Address",
                    errorMessage: "please enter your address",
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 5),
                  const Text("PIN/ZIP CODE *"),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    controller: pincodeController,
                    readMode: false,
                    hintText: "PIN/ZIP CODE",
                    keyboardType: TextInputType.number,
                    errorMessage: "Please enter your zip code",
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    child: const Text("Submit"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_userTypeValue == null) {
                          message(context, "Please select car");
                        } else {
                          upDateUserData();
                          message(context, 'Updated Suceesfully!');
                        }
                      }
                    },
                    style: kElevatedButtonstyle,
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  // _sendSMS(msg, recipents);
                },
                child: const Text('Send the registration link to customer'))
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  void upDateUserData() {
    print(userid);
    print(firstNameController.text);

    print(addressController.text);
    print(phoneController.text);

    print(pincodeController.text);
    print(_userTypeValue);

    var data = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'mobile': phoneController.text,
      'address': addressController.text,
      'postal_code': pincodeController.text,
      'avatar': '',
      'city': '',
      'country': '',
      'address_secondary': '',
      'language': '',
      'description': ''
    };

    CallApi().updateDataIntoDataBase(data, '/fleet_update/', userid.toString());
  }

  // void _sendSMS(String message, List<String> recipents) async {
  //   String _result = await sendSMS(message: message, recipients: recipents)
  //       .catchError((onError) {
  //     print(onError);
  //   });
  //   print(_result);
  // }
}
