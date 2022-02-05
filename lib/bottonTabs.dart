import 'package:cargpstracker/MainTabScreens/history.dart';
import 'package:cargpstracker/MainTabScreens/live.dart';
import 'package:cargpstracker/MainTabScreens/setting.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    Setting(),
    Live(),
    History(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Setting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        // fixedColor: Colors.red,
        selectedLabelStyle: TextStyle(color: Colors.red, fontSize: 20),
        unselectedFontSize: 16,
        selectedIconTheme:
            IconThemeData(color: Colors.blue, opacity: 1.0, size: 30.0),
        unselectedItemColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontSize: 18, color: Colors.pink),
      ),
    );
  }
}