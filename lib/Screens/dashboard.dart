import 'package:aioft_bpo/Screens/home_screen.dart';
import 'package:aioft_bpo/Screens/profile_screen.dart';
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
  final List<Widget> _widgetOptions = <Widget>[
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
      bottomNavigationBar: SizedBox(
        height: 70,
        child: bottomNavigations(),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }

  BottomNavigationBar bottomNavigations() {
    return BottomNavigationBar(
      backgroundColor: kCardColor,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            size: 32,
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kBtnColor,
      unselectedItemColor: kIconTextColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
