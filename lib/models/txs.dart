import 'package:flutter/material.dart';

class TransClass with ChangeNotifier {
  String type;
  String txHash;
  int blockHeigh;
  int index;
  int value;


  TransClass({
    @required this.type,
    @required this.txHash,
    @required this.blockHeigh,
    @required this.index,
    @required this.value,
  });

  List testTxHisory = [];
}
