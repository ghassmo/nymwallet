import 'package:flutter/material.dart';
import 'package:nymwal/shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBarCustom(
          title: "History",
          icon: OMIcons.accountBalanceWallet,
          iconString: true,
        ),
      ],
    );
  }
}
