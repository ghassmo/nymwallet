
// import 'package:bitcoin_flutter/src/payments/p2pkh.dart' show P2PKH;
// import 'package:bitcoin_flutter/src/payments/index.dart' show PaymentData;
// import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:web_socket_channel/io.dart';

import './providers/trans_provider.dart';
import './screens/tab_screen.dart';
import './data_stream.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final dataStream dataSt =
      new dataStream();

  // new dataStream(IOWebSocketChannel.connect('ws://85.90.245.20:8765'));

 

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Trans(dataSt),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(255, 248, 232, 1),
            primarySwatch: Colors.red,
            buttonTheme: ButtonThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red),
              ),
            )),
        home: TabScreen(),
      ),
    );
  }
}

//   final keyPair =
//       ECPair.fromWIF('cVks5KCc8BBVhWnTJSLjr5odLbNrWK9UY4KprciJJ9dqiDBenhzr');
//   final testnet = NETWORKS.testnet;
//   final address = new P2PKH(
//           data: new PaymentData(pubkey: keyPair.publicKey), network: testnet)
//       .data
//       .address;
