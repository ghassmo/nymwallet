import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import '../providers/trans_provider.dart';
import '../shared/appBar.dart';

class HistoryScreen extends StatelessWidget {
  TextStyle buildTextStyle(String s) {
    if (s == "output") {
      return TextStyle(
          color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold);
    }
    return TextStyle(
        color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    final trans = Provider.of<Trans>(context);
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
            top: 150,
            child: Container(
              height: queryData.size.height / 1.35,
              width: queryData.size.width / 1.2,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return trans.listOftrans.isEmpty ? CircularProgressIndicator() : Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            trans.listOftrans[index].txHash,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                trans.listOftrans[index].value.toString(),
                                style: buildTextStyle(
                                    trans.listOftrans[index].type),
                              ),
                              Text(
                                trans.listOftrans[index].type.toString(),
                                style: buildTextStyle(
                                    trans.listOftrans[index].type),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: trans.listOftrans.length,
              ),
            ))
      ],
    );
  }
}
