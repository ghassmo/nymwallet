import 'package:flutter/material.dart';
import 'package:nymwal/screens/history_screen.dart';
import 'package:nymwal/screens/home_screen.dart';
import 'package:nymwal/screens/receive_screen.dart';
import 'package:nymwal/screens/send_screen.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromRGBO(255, 248, 232, 1),
          primarySwatch: Colors.red,
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          )),
      title: '',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyHomePage> {
  int _selectedItem = 0;

  final List<Widget> _childerWidgets = [
    HomeScreen(),
    SendScreen(),
    ReceiveScreen(),
    HistoryScreen(),
  ];

  void _selectItem(int i) {
    setState(() {
      _selectedItem = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _childerWidgets[_selectedItem]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).primaryColor.withOpacity(0.5),
          onTap: _selectItem,
          currentIndex: _selectedItem,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(OMIcons.home),
            ),
            BottomNavigationBarItem(
                title: Text("Send"), icon: Icon(OMIcons.send)),
            BottomNavigationBarItem(
                title: Text("Receive"), icon: Icon(OMIcons.arrowDownward)),
            BottomNavigationBarItem(
                title: Text("History"), icon: Icon(OMIcons.history)),
          ],
        ));
  }
}
