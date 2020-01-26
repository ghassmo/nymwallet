import 'package:flutter/material.dart';
import 'package:nymwal/shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

InputDecoration buildInputDec(String title, IconData icon, Function onPress) {
  return InputDecoration(
    enabledBorder:
        new UnderlineInputBorder(borderSide: new BorderSide(color: Colors.red)),
    labelText: title,
    labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    suffixIcon: IconButton(
      icon: Icon(icon),
      color: Colors.red,
      onPressed: onPress,
    ),
  );
}

class SendScreen extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBarCustom(
          title: "Send",
          icon: OMIcons.accountBalanceWallet,
          iconString: true,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: buildInputDec(
                          "Pay to", OMIcons.centerFocusStrong, () {}),
                    ),
                    TextFormField(
                      decoration:
                          buildInputDec("Amount", OMIcons.arrowRight, () {}),
                    ),
                    Padding(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Fee: ",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                          Slider(
                            value: 0.2,
                            min: 0.0,
                            max: 100.0,
                            divisions: 2,
                            onChanged: (double value) {},
                          ),
                          Text(
                            "0.0",
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {},
                            child: const Text(
                              "Send",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.white)),
                            onPressed: () {},
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
        )
      ],
    );
  }
}
