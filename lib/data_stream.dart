import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Part {
  int index;
  String payload;
  Part(this.index, this.payload);
}

class dataStream {
  StreamSubscription streamSub;
  WebSocketChannel websocket;
  Map<String, List<Part>> parts = {};
  int sizeLimit = 500;

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
        await request("send",
            params: {"message": msg, "recipient_address": recipient});

        await request("fetch").then((d) {
          List<dynamic> dataToProcess = d["messages"];
          dataToProcess.forEach((d){
            process(json.decode(d));
          });
        });
        // print("parts: " + parts.toString());

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

  Future<void> initData() async {
    try {
      var address;

      await request("ownDetails").then((d) {
        address = d["address"];
      });

      var blockchainReq =
          '{"command":"fetch_history", "addrs":["mtovQPnUuCeAUJkhqZn5vJ99vxJYNGXoEn"],"return-recipient":"$address"}';

      var nymAddress = "AGdb5ZwZBpazKysh9ijCwgzCVRYcvadEhvaxQ3mkBnur";
      // print(blockchainReq);
      await send(blockchainReq, nymAddress);

    } catch (e) {
      print("Error Occored:  " + e.toString());
    }
  }

  Map<String, dynamic> getHistory() {
    Map<String, dynamic> newMap = {};
    parts.forEach((k, v) {
      var partsString = "";
      v.sort((a, b) => a.index.compareTo(b.index));
      for (var i in v) {
        partsString = '$partsString ${i.payload}';
      }
      newMap[k] = partsString;
    });
    // print(newMap);
    return newMap;
  }

  Future<dynamic> request(String messageType, {Map params}) async {
    try {
      this.websocket = IOWebSocketChannel.connect('ws://127.0.0.1:9001');
      var dataLoaded;

      Map reqObject = {"type": messageType};

      if (params != null) {
        reqObject.addAll(params);
      }
      print(json.encode(reqObject));

      this.websocket.sink.add(json.encode(reqObject));
      streamSub = websocket.stream.listen(
        (data) {
          dataLoaded = json.decode(data);
          // print(parts);
        },
        onError: (e) {
          print("onError $e");
        },
        onDone: () {
          print("onDone");
        },
      );

      await Future.delayed(Duration(seconds: 6));
      websocket.sink.close();
      return dataLoaded;
    } catch (e) {
      print("error happened in requesrt:" + e.toString());
    }
  }
}
