import 'package:flutter/material.dart';
import 'package:nymwal/shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class ReceiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBarCustom(
          title: "Receive",
          icon: OMIcons.accountBalanceWallet,
          iconString: true,
        ),
      ],
    );
  }
}
