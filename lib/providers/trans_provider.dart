import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:nymfinal/models/txs.dart';

import '../data_stream.dart';

class Trans with ChangeNotifier {
  DataStream dataSt;
  double balance;
  Trans(this.dataSt);
  bool isStreamOn = false;

  List<TransClass> listOftrans = [];
  List<String> addedBefore = [];

  Future<void> loadDataFromStream() async {
    try {
      // await this.dataSt.loadWallet();
      if (!isStreamOn) {
        var datamap = await this.dataSt.getHistory();
        await Future.delayed(Duration(seconds: 2));
        datamap.forEach((k, v) {
          if (!addedBefore.contains(k)) {
            addToList(v);
          }
        });
        isStreamOn = true;
      }
    } catch (e) {
      print("error occured in load data:" + e.toString());
    }
  }

  addToList(dynamic data) {
    var newData = json.decode(data);
    List<TransClass> newList = [];
    newData.forEach((k, v) {
      for (var item in v) {
        var newItem = new TransClass(
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
    this.balance = newBalance / 100000;
    notifyListeners();
  }

  getData() {
    return [...this.listOftrans];
  }

  getBalance() {
    return balance;
  }

  Map<String, int> findPreHash(int d) {
    var tmp = 0;
    Map<String, int> tmpList = {};
    for (var i in listOftrans) {
      tmp += i.value;
      tmpList[i.txHash] = i.value;
      if (tmp > d) {
        return tmpList;
      }
    }
    return {};
  }

  getAddress() {
    return this.dataSt.btc_address;
  }

  getPk() {
    return this.dataSt.pk;
  }

  Future<void> buildTrans(int fee, int amount, String dest) async {
    final add = ECPair.fromWIF(this.dataSt.pk, network: testnet);

    final txb = new TransactionBuilder(network: testnet, maximumFeeRate: fee);

    txb.setVersion(1);
    var txHash = findPreHash(amount);
    int amountRecevied = 0;
    var inputCount = 0;
    print(txHash);
    txHash.forEach((i, v) {
      amountRecevied += v;
      txb.addInput(i, inputCount);
      inputCount++;
    });
    var amountToSend  = amountRecevied - (fee.toInt() - 1);
    txb.addOutput(dest, amountToSend);
    if (amountToSend > amount){
      txb.addOutput(this.dataSt.btc_address, amountToSend - amount);
    }
    var signCount = inputCount - 1;
    while (signCount >= 0) {
      txb.sign(signCount, add);
      signCount--;
    }
    print(txb.build().toHex());
    await this.dataSt.sendFunds(txb.build().toHex());
  }
}
