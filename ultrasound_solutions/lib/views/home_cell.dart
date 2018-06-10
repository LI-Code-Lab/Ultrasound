import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/models/colors.dart';

class HomeCell extends StatelessWidget {
  final title;
  final icon;
  final color;

  final iconSize = 45.0;
  final titleSize = 18.0;

  HomeCell(this.title, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: color,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCell()
        ],
      ),
    );
  }

  Widget _buildCell() {
    return new Container(
      width: 350.0,
      margin: new EdgeInsets.all(8.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            width: 75.0,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(icon, size: iconSize, color: kUltraSoundSurfaceWhite)
              ],
            ),
          ),
          new Container(
            width: 275.0,
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(title, textAlign: TextAlign.center, style: new TextStyle(fontSize: titleSize))
              ],
            ),
          )
        ],
      ),
    )
  }
}
