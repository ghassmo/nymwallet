import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/trans_provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../shared/appBar.dart';

class ReceiveScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var trans = Provider.of<Trans>(context);
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: AppBarCustom(
                title: "History",
                icon: OMIcons.accountBalanceWallet,
                iconString: true)),
        Positioned(
            top: 200,
            child: Column(
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: QrImage(
                      data: trans.dataSt.btc_address,
                      version: QrVersions.auto,
                      size: 250,
                      gapless: false),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text(trans.dataSt.btc_address, style: TextStyle(fontWeight: FontWeight.bold),),
                      IconButton(
                        icon: Icon(OMIcons.fileCopy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: trans.dataSt.btc_address));
                        },
                      )
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
