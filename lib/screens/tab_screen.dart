import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

import '../providers/trans_provider.dart';
import '../screens/receive_screen.dart';
import '../screens/send_screen.dart';
import './history_screen.dart';
import './home_screen.dart';

class TabScreen extends StatefulWidget {
  get dataSt => null;

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedItem = 0;
  bool isLoading = false;

  void _selectItem(int i) {
    setState(() {
      _selectedItem = i;
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  final List<Widget> _childerWidgets = [
    HomeScreen(),
    SendScreen(),
    ReceiveScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final transPr = Provider.of<Trans>(context, listen: false);
    Future.delayed(Duration(seconds: 1)).then((_) {
      transPr.loadDataFromStream();
    });
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
