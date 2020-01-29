import 'package:flutter/material.dart';
import '../shared/appBar.dart';
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
  // final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Align(
            alignment: Alignment.topCenter,
            child: AppBarCustom(
              title: "Send",
              icon: OMIcons.accountBalanceWallet,
              iconString: true,
            )),
        Positioned(
          top: 125,
          child: Container(
            height: 370,
            padding: EdgeInsets.all(15),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: buildInputDec(
                              "Pay to", OMIcons.centerFocusStrong, () {}),
                        ),
                      ),
                      Container(
                        width: 300,
                        child: TextFormField(
                          decoration: buildInputDec(
                              "Amount", OMIcons.arrowRight, () {}),
                        ),
                      ),
                      Padding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Fee: ",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                Slider(
                                  value: 0.2,
                                  min: 0.0,
                                  max: 100.0,
                                  divisions: 2,
                                  onChanged: (double value) {},
                                ),
                                IconButton(
                                  icon: Icon(OMIcons.autorenew),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {},
                                )
                              ],
                            ),
                            Text(
                              "0.0 Satochi",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
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
                              child: Text(
                                "Send",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.white)),
                              onPressed: () {},
                              child: Text(
                                "Clear",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        )
      ],
    );
  }
}
