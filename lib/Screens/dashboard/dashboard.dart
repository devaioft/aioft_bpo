import 'package:aioft_bpo/Screens/home/home_screen.dart';
import 'package:aioft_bpo/Screens/profile/profile_screen.dart';
import 'package:aioft_bpo/constant.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    setState(() {
      context;
    });
    return Scaffold(
      backgroundColor: kPrimaryColor,
      bottomNavigationBar: bottomNavigationbar(),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: _screens[_selectedIndex],
      ),
    );
  }

  NavigationBarTheme bottomNavigationbar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        indicatorColor: kIconEnabledColor,
        iconTheme: MaterialStateProperty.all(
          const IconThemeData(
            color: kBtnColor,
            opacity: 0.7,
          ),
        ),
        labelTextStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 15,
            color: kTextColor,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        height: 70,
        backgroundColor: kCardColor,
        animationDuration: const Duration(seconds: 1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_outline,
              size: 28,
            ),
            selectedIcon: Icon(
              Icons.person,
              size: 28,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
