import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_cell.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  final listCount = 3;
  final titles = ["Schedule Service", "Snap A Pic & Get An Online Estimate", "I Have An Emergency"];
  final icons = [Icons.calendar_today, Icons.camera_alt, Icons.call];
  final colors = [Colors.blue, Colors.tealAccent, Colors.red];
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: _buildHomeList(),
      ),
    );
  }
  
  Widget _buildHomeList(){
    return new ListView.builder(
      itemCount: listCount,
      itemExtent: 125.0,
      itemBuilder: (context, index) {
        return new FlatButton(
            onPressed: () {
              //navigate to next screen
            }, 
            child: new HomeCell(
                titles[index],
                icons[index],
                colors[index]),
          padding: new EdgeInsets.all(0.0),
        );
      });
  }
}

