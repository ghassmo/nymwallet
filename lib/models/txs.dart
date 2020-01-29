import 'package:flutter/material.dart';

class Transaction with ChangeNotifier {
  String type;
  String txHash;
  int blockHeigh;
  int index;
  int value;


  Transaction({
    @required this.type,
    @required this.txHash,
    @required this.blockHeigh,
    @required this.index,
    @required this.value,
  });

  List testTxHisory = [];
}
