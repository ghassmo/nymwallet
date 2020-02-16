import 'dart:convert';
import 'package:flutter/material.dart';

import '../data_stream.dart';
import '../models/txs.dart';
import '../models/txs.dart';

class Trans with ChangeNotifier {
  dataStream dataSt;
  double balance;
  Trans(this.dataSt);

  List<Transaction> listOftrans = [];
  List<String> addedBefore = [];

  Future<void> loadDataFromStream() async {
    await Future.delayed(Duration(seconds: 5), () {
      this.dataSt.getHistory().forEach((k, v) {
        if (!addedBefore.contains(k)) {
          addToList(v);
        }
      });
    });
  }

  addToList(String data) {
    Map newData = json.decode(data);
    List<Transaction> newList = [];
    newData.forEach((k, v) {
      for (var item in v) {
        var newItem = new Transaction(
            type: item[0],
            txHash: item[1],
            index: item[2],
            blockHeigh: item[3],
            value: item[4]);
        newList.add(newItem);
      }
    });
    this.listOftrans = newList;
    double newBalance = 0;
    for (var item in listOftrans) {
      newBalance += item.value;
    }
    this.balance = newBalance * 10000000;
    notifyListeners();
  }

  getData() {
    return [...this.listOftrans];
  }
}
