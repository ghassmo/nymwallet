import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final IconData icon;
  final String iconString;

  AppBarCustom({@required this.title, @required this.icon,  this.iconString});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 40),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          iconString  == null ? 
          IconButton(
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {}, 
            
          ) : FlatButton.icon(
            icon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {}, 
            label: Text(iconString),
          )
        ],
      ),
    );
  }
}
