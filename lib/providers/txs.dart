import 'package:flutter/material.dart';

class Transaction with ChangeNotifier {
  double amount;
  String txHash;
  int blockHeigh;

  Transaction(
      {@required this.amount,
      @required this.txHash,
      @required this.blockHeigh});

  List testTxHisory = [];
}
