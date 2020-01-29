import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Part {
  int index;
  String payload;
  Part(this.index, this.payload);
}

class dataStream {
  final WebSocketChannel websocket;
  Map<String, List<Part>> parts = {};
  int sizeLimit = 500;

  dataStream(this.websocket);

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

  Future<void> send(String data) async {
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
        websocket.sink.add(msg);
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
      await send(
          '{"command":"fetch_history", "addrs":["mtovQPnUuCeAUJkhqZn5vJ99vxJYNGXoEn"],"return-recipient":"none"}');
      websocket.stream.listen(
        (data) {
          var dataLoaded = jsonDecode(data);
          process(dataLoaded);
          // print(parts);
        },
        onError: (e) {
          print("onError $e");
        },
        onDone: () {
          print("onDone");
        },
      );
      Timer(Duration(seconds: 10), () {
        return getHistory();
      });
      // print(parts);
    } catch (e) {
      print("Error Occored: $e ");
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
}
