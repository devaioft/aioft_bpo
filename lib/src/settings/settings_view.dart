import 'package:aioft_bpo/Services/preferences.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:flutter/material.dart';
import 'settings_controller.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _prefs = PreferecesServices();
  @override
  void initState() {
    super.initState();
    populatesField();
  }

  populatesField() async {
    final setting = await _prefs.getData();
    setState(() {
      _phoneController.text = setting.phoneNumber!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 1,
              child: Container(
                margin: const EdgeInsets.all(12),
                height: 43,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ThemeMode>(
                    value: widget.controller.themeMode,
                    onChanged: widget.controller.updateThemeMode,
                    items: const [
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('System Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('Light Theme'),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('Dark Theme'),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Form(
              key: _formKey,
              child: Column(
                children: [
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
                      if(value.length<10){
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
                  final newSetting =
                      Settings(phoneNumber: _phoneController.text);
                  setState(() {
                    _prefs.setData(newSetting);
                  });
                  Message(context, 'Updated Succesfully!');
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
