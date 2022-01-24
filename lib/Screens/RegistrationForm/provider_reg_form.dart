import 'package:aioft_bpo/Models/user_model.dart';
import 'package:aioft_bpo/Screens/RegistrationForm/components/custom_text_field.dart';
import 'package:aioft_bpo/Widgets/message.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class ProviderRegistartion extends StatefulWidget {
  const ProviderRegistartion({Key? key, this.provider}) : super(key: key);
  static const routeName = "/pDetail";

  final Provider? provider;

  @override
  _ProviderRegistartionState createState() => _ProviderRegistartionState();
}

class _ProviderRegistartionState extends State<ProviderRegistartion> {
  // final preferences = PreferencesData();

  DateTime selectedDate = DateTime.now();

  final _formKey = GlobalKey<FormState>();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();
  final pincodeController = TextEditingController();
  String? carTypeValue;
  final items = ['Provider', 'Fleet'];

  @override
  void initState() {
    super.initState();

    setState(() {
      fullNameController.text =
          "${widget.provider!.firstName ?? ''}  ${widget.provider!.lastName ?? ''}";

      addressController.text = widget.provider!.address ?? 'Bangalore';
      phoneController.text = widget.provider!.mobile ?? '';
      pincodeController.text = widget.provider!.pinCode ?? '123456';
      carTypeValue = items[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.provider!.firstName!),
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
                            value: carTypeValue,
                            iconSize: 30,
                            icon: const Icon(
                              Icons.arrow_drop_down_circle_outlined,
                              color: Colors.lightBlueAccent,
                            ),
                            isExpanded: true,
                            items: items.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(() {
                              carTypeValue = value.toString();
                            }),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text("FULL NAME *"),
                    const SizedBox(height: 5),
                    CustomTextFormField(
                      controller: fullNameController,
                      hintText: "your full name",
                      readMode: false,
                      keyboardType: TextInputType.text,
                      errorMessage: "Please enter full name",
                    ),
                    const SizedBox(height: 5),
                    const Text("PHONE NUMBER *"),
                    const SizedBox(height: 10),
                    CustomTextFormField(
                      controller: phoneController,
                      hintText: "phone no",
                      readMode: true,
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
                          // print(fullNameController.text);
                          // print(lastnameController.text);
                          // print(fullAdressController.text);
                          // print(addressController.text);
                          // print(dateOfBirth);
                          // print(phoneController.text);
                          // print(pincodeController.text);
                          // print(carTypeValue);
                          if (carTypeValue == null) {
                            message(context, "Please select car");
                          } else {
                            saveUserData();
                            // Navigator.pushNamed(
                            //     context, UploadDocumnet.routeName);
                          }
                        }
                      },
                      style: kElevatedButtonstyle,
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );

  void saveUserData() {
    // final newData = UserModel(
    //   carType: carTypeValue,
    //   firstName: fullNameController.text,
    //   lastName: lastnameController.text,
    //   cityName: fullAdressController.text,
    //   address: addressController.text,
    //   dob: dateOfBirth.toString(),
    //   pinCode: pincodeController.text,
    //   phone: phoneController.text,
    // );
    // print(newData);
    // preferences.saveData(newData);
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1985),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
}
