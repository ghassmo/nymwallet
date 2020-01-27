import 'package:flutter/material.dart';
import 'package:nymwal/shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: AppBarCustom(
                title: "Home", icon: OMIcons.accountCircle, iconString: false)),
        Positioned(
          top: 200,
          child: Text(
            "0.0mBtc",
            style: TextStyle(
                fontSize: 30,
                color: Theme.of(context).scaffoldBackgroundColor,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
