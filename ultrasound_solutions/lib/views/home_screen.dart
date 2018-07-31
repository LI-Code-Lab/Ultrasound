import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_cell.dart';
import 'package:url_launcher/url_launcher.dart';
import 'service_form_screen.dart';
import 'estimate_form_screen.dart';
import 'package:ultrasound_solutions/models/colors.dart';

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
  final colors = [Colors.blue, Colors.green, Colors.red];
  final phoneNumber = "tel://18007734582";
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Column(
          children: <Widget>[
            _buildHomeList(),
            _buildGuarantee()
          ],
        ),
      ),
    );
  }
  
  Widget _buildHomeList(){
    return Expanded(
      child: new ListView.builder(
        itemCount: listCount,
        itemExtent: 125.0,
        itemBuilder: (context, index) {
          return new FlatButton(
              onPressed: () {
                //navigate to next screen
                if(index == 0){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceFormScreen()));
                }
                if(index == 1){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EstimateFormScreen()));
                }
                if(index == 2){
                  launch(phoneNumber);
                }
              },
              child: new HomeCell(
                  titles[index],
                  icons[index],
                  colors[index]),
            padding: new EdgeInsets.all(0.0),
          );
        }),
    );
  }
  
  Widget _buildGuarantee(){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(Icons.beenhere, size: 34.0, color: kUltraSoundPrimaryText),
              new Text("Quality Guarantee", style: new TextStyle(fontSize: 16.0, color: kUltraSoundPrimaryText, fontWeight: FontWeight.bold))
            ],
          ),
          new Text("You!, our customer are guaranteed complete satisfaction. If for any reason, you are not completley satisfied with your experience please let us know so it can be rectified. Thank you for your business!", style: new TextStyle(fontSize: 16.0, color: kUltraSoundPrimaryText))
        ],
      ),
    );
  }
}

