import 'dart:async';
import 'dart:convert';
import 'package:bitcoin_flutter/bitcoin_flutter.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:bitcoin_flutter/src/payments/p2pkh.dart' show P2PKH;
import 'package:bitcoin_flutter/src/payments/index.dart' show PaymentData;
import 'package:bitcoin_flutter/src/models/networks.dart' as NETWORKS;
import 'package:crypto/crypto.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:bip32/bip32.dart' as bip32;

class Part {
  int index;
  String payload;
  Part(this.index, this.payload);
}

class DataStream {
  final storage = new FlutterSecureStorage();
  WebSocketChannel websocket;
  Map<String, List<Part>> parts = {};
  int sizeLimit = 500;
  String pk = "cVks5KCc8BBVhWnTJSLjr5odLbNrWK9UY4KprciJJ9dqiDBenhzr";
  String btc_address = "mtovQPnUuCeAUJkhqZn5vJ99vxJYNGXoEn";

  Future<void> loadWallet() async {
    var words = await storage.read(key: "bip39Words");
    if (words == null) {
      // generate wallet
      words = bip39.generateMnemonic();
      // save wallet
      await storage.write(key: "bip39Words", value: words);
    }

    var seed = bip39.mnemonicToSeed(words);
    var root = bip32.BIP32.fromSeed(seed);

    // save address

    final testnet = NETWORKS.testnet;
    btc_address = new P2PKH(
            data:
                new PaymentData(pubkey: root.derivePath("m/0'/0/0").publicKey),
            network: testnet)
        .data
        .address;
  }

  // gen data_id
  Digest computeId(Digest digest) {
    var id = sha256.convert(digest.bytes);
    return id;
  }

  String reve(String s) {
    var newList = [];
    for (var i = 0; i < s.length; i += 2) {
      newList.add(s.substring(i, i + 2));
    }
    return newList.reversed.join();
  }

  String genId(String data) {
    var id = computeId(sha256.convert(utf8.encode(data))).toString();
    return reve(id);
  }

  // spplite string to chunks
  List spliteString(String data, int size) {
    List<String> res = [];
    if (data.length <= size) {
      res.add(data);
    } else {
      for (int i = 0; (i + size) <= data.length; i += size) {
        res.add(data.substring(i, (size + i)));
      }
    }
    return res;
  }

  Future<void> send(String data, recipient) async {
    List chunks = spliteString(data, sizeLimit);

    var dataId = genId(data);

    try {
      int i = 0;
      for (var chunk in chunks) {
        Map<String, dynamic> message = {
          "id": dataId,
          "payload": chunk,
          "index": i
        };
        i++;
        var msg = json.encode(message);
        print("send: " + msg);
        await request("send",
            params: {"message": msg, "recipient_address": recipient});
      }
    } catch (e) {
      print("error Occured in send: $e ");
    }
  }

  void process(Map<String, dynamic> data) {
    if (!parts.containsKey(data["id"])) {
      parts[data["id"]] = [];
    }
    parts[data["id"]].add(new Part(data["index"], data["payload"]));
  }

  Future<Map<String, dynamic>> getHistory() async {
    try {
      var address;

      await request("ownDetails").then((d) {
        print("ownDetails");
        address = d["address"];
        print(address);
      });
      websocket.sink.close();

      var blockchainReq =
          '{"command":"fetch_history", "addrs":["mtovQPnUuCeAUJkhqZn5vJ99vxJYNGXoEn"],"return-recipient":"$address"}';

      var nymAddress = "AGdb5ZwZBpazKysh9ijCwgzCVRYcvadEhvaxQ3mkBnur";
      await send(blockchainReq, nymAddress);
      websocket.sink.close();

      var df = await request("fetch");
      print("type fetch");
      await Future.delayed(Duration(seconds: 2));
      websocket.sink.close();

      List<dynamic> dataToProcess = df["messages"];
      dataToProcess.forEach((d) {
        process(json.decode(d));
      });

      Map<String, dynamic> newMap = {};
      print(parts);
      parts.forEach((k, v) {
        var partsString = "";

        v.sort((a, b) => a.index.compareTo(b.index));

        for (var i in v) {
          partsString += i.payload;
        }
        newMap[k] = partsString.toString();
      });
      parts = {};
      return newMap;
    } catch (e) {
      print("error occured getHIstory: $e");
    }
  }

  Future<dynamic> request(String messageType, {Map params}) async {
    try {
      this.websocket = IOWebSocketChannel.connect('ws://127.0.0.1:9001');

      var dataLoaded;

      Map reqObject = {"type": messageType};

      if (params != null) {
        reqObject.addAll(params);
      }

      this.websocket.sink.add(json.encode(reqObject));
      websocket.stream.listen(
        (data) {
          dataLoaded = json.decode(data);
        },
        onError: (e) {
          print("onError $e");
        },
        onDone: () {
          print("onDone");
        },
      );
      await Future.delayed(Duration(seconds: 1));

      return dataLoaded;
    } catch (e) {
      print("error happened in requesrt:" + e.toString());
    }
  }

  Future<void> sendFunds(String hexTrans) async {
    var request = '{"command": "broadcast", "tx_data": $hexTrans}';
    var nymAddress = "kauuj71-RPvETjz8FMQugnsNSDJ8033E4lNS_anMFD0=";
    await this.send(request, nymAddress);
    websocket.sink.close();
  }
}
