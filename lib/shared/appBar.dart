import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/trans_provider.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool iconString;

  AppBarCustom({@required this.title, this.icon, this.iconString = false});
  @override
  Widget build(BuildContext context) {
    var trans = Provider.of<Trans>(context);
    var queryData = MediaQuery.of(context);
    return Stack(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          height: queryData.size.height / 3,
        ),
        Container(
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
                      color: Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              FlatButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor)),
                icon: Icon(
                  icon,
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                onPressed: () {},
                label: Text(
                  iconString ? trans.balance.toString() + " mBtc" : " ",
                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
