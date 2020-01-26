import 'package:flutter/material.dart';
import 'package:nymwal/shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBarCustom(
          title: "Home",
          icon: OMIcons.accountCircle,
        ),
      ],
    );
  }
}
