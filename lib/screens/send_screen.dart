import 'package:flutter/material.dart';
import 'package:nymfinal/providers/trans_provider.dart';
import 'package:provider/provider.dart';
import '../shared/appBar.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  final _form = GlobalKey<FormState>();

  String dest = "";

  String amount = "";

  double fee = 0;
  var isSending = false;

  InputDecoration buildInputDec(String title, IconData icon, Function onPress) {
    return InputDecoration(
      enabledBorder: new UnderlineInputBorder(
          borderSide: new BorderSide(color: Colors.red)),
      labelText: title,
      labelStyle:
          const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
      suffixIcon: IconButton(
        icon: Icon(icon),
        color: Colors.red,
        onPressed: onPress,
      ),
    );
  }

  Future<void> buildTrans(Trans t) async {
    try {
      isSending = true;
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      this._form.currentState.reset();
      await t.buildTrans(fee.toInt(), int.parse(amount), dest);
      isSending = false;
    } catch (e) {
      print("error Occured in buildTrans_send_screen" + e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var trans = Provider.of<Trans>(context);
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
            height: 450,
            padding: EdgeInsets.all(15),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 300,
                          child: TextFormField(
                            initialValue: dest,
                            decoration: buildInputDec(
                                "Pay to", OMIcons.centerFocusStrong, () {}),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              this.dest = value;
                              print(this.dest);
                            },
                          ),
                        ),
                        Container(
                          width: 300,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: buildInputDec(
                                "Amount", OMIcons.arrowRight, () {}),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an amount.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              this.amount = value;
                            },
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
                                    value: fee,
                                    min: 0,
                                    max: 10000,
                                    onChanged: (double value) {
                                      setState(() {
                                        fee = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                "${fee.toStringAsFixed(0)} Satochi",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(top: 20),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: isSending
                              ? CircularProgressIndicator()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        buildTrans(trans);
                                      },
                                      child: Text(
                                        "Send",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(18.0),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      onPressed: () {
                                        _form.currentState.reset();
                                      },
                                      child: Text(
                                        "Clear",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }
}
