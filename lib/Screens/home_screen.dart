import 'package:aioft_bpo/Models/driver_model.dart';
import 'package:aioft_bpo/Models/popup_menu_model.dart';
import 'package:aioft_bpo/Services/api.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:aioft_bpo/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Drivers>>? _driversFuture;
  final CallApi _callApi = CallApi();
  String _value = "";
  final List<PopupItem> _list =[
  PopupItem(value: 'Fleet', child:const  Text("Owned List")),
    PopupItem(value: 'Owned', child: const  Text("Fleet List")),
    PopupItem(value: '', child: const  Text("Show All List")),
  ];

  @override
  void initState() {
    super.initState();
    _driversFuture = _callApi.fetchDriver('/taxeelist');
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: const Text("DriverList"),
      actions: [
        IconButton(
          onPressed: () =>
              Navigator.restorablePushNamed(context, SettingsView.routeName),
          icon: const Icon(Icons.settings),
        ),
        PopupMenuButton(
          elevation: 10,
          enabled: true,
          onSelected: (value) {
            setState(() {
              _value = value.toString();
            });
          },
          itemBuilder: (context) {
            return _list.map(
              (PopupItem choice) {
                return PopupMenuItem(
                  value: choice.value,
                  child: choice.child,
                );
              },
            ).toList();
          },
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: FutureBuilder<List<Drivers>>(
          future: _driversFuture,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final driver = snapshot.data![index];

                    if (snapshot.data![index].carType == _value) {
                      return const Visibility(
                        visible: false,
                        maintainState: true,
                        maintainAnimation: true,
                        maintainSize: false,
                        child: Text("data"),
                      );
                    } else {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 3),
                        elevation: 0.8,
                        child: ListTile(
                          title: DriverNameWdget(driver: driver),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text('${driver.cityName}'),
                              ),
                              Text("${driver.carType}")
                            ],
                          ),
                          trailing: OutlinedButton(
                            onPressed: () => {bottomSheet(context, driver)},
                            child: const Icon(Icons.call, color: Colors.green),
                          ),
                        ),
                      );
                    }
                  });
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
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
        return Container(
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BottomSheetButton(
                btnTitle: 'Call ${drivers.firstName}',
                primaryColor: Colors.green,
                onPressed: () => {_callNumber(drivers.phoneNumber!)},
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

  _callNumber(String driverNumber) async {
    var number = driverNumber; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
}

class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({
    Key? key,
    this.btnTitle,
    this.onPressed,
    this.primaryColor,
  }) : super(key: key);

  final String? btnTitle;
  final void Function()? onPressed;
  final Color? primaryColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          child: Text(
            btnTitle!,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            primary: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      ),
    );
  }
}



class DriverNameWdget extends StatelessWidget {
  const DriverNameWdget({
    Key? key,
    required this.driver,
  }) : super(key: key);

  final Drivers driver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${driver.firstName} ${driver.lastName}',
        style: kDriverNameStyle,
      ),
    );
  }
}
