import 'package:aioft_bpo/Screens/dashboard.dart';
import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();

  final _prefs = PreferecesServices();

  @override
  void initState() {
    super.initState();
    populatesField();
  }

  populatesField() async {
    final profile = await _prefs.getData();
    setState(() {
      _phoneController.text = profile.phoneNumber??'';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: kCardColor,
                  child: IconButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashBoardScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: kIconTextColor,
                    ),
                  ),
                ),
              ],
            ),
            Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      text: 'Add Agent Number\n\n',
                      style: TextStyle(
                        color: kBtnColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Nunito-Bold',
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Who wants to first  attend the call?',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 1.0, bottom: 10),
                    child: Text(
                      "Agent Mobile Number",
                      style: TextStyle(
                        color: kBtnColor,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      hintText: 'Enter agent mobile number',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter agent mobile number';
                      }
                      if (value.length < 10) {
                        return 'Please enter valid agent mobile number';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (_phoneController.text.length < 10 ||
                      _phoneController.text.length > 10) {
                    message(context, 'Please Enter a valid number');
                  } else {
                    final newProfile =
                        Profile(phoneNumber: _phoneController.text);
                    setState(() {
                      _prefs.setData(newProfile);
                    });
                    message(context, 'Updated Succesfully!');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashBoardScreen()));
                  }
                }
              },
              child: Text(
                _phoneController.text.isEmpty ? 'Add ' : 'Update',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: kBtnColor,
                onPrimary: kCardColor,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
