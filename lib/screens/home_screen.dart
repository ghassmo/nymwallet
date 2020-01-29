import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../providers/trans_provider.dart';
import '../shared/appBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var trans = Provider.of<Trans>(context);
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
            trans.balance.toString() + " mBtc",
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
