import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool iconString;

  AppBarCustom({@required this.title, this.icon, this.iconString = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 40),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          FlatButton.icon(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Theme.of(context).scaffoldBackgroundColor)),
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
            label: Text(iconString ? "0.0 mBtc" : " ", style: TextStyle(color: Colors.red),),
          )
        ],
      ),
    );
  }
}
