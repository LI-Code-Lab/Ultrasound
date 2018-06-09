import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/models/colors.dart';

class HomeCell extends StatelessWidget {
  final title;
  final icon;
  final color;

  final iconSize = 50.0;
  final titleSize = 18.0;

  HomeCell(this.title, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: color,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildCellContent()
        ],
      ),
    );
  }

  Widget _buildCellContent(){
    return new Container(
      width: 300.0,
      margin: new EdgeInsets.all(8.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(icon, size: iconSize, color: kUltraSoundSurfaceWhite),
          new Text(title, textAlign: TextAlign.center, style: new TextStyle(fontSize: titleSize))
        ],
      ),
    );
  }
}
