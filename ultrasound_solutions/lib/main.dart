import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'USC & Me',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new MyHomePage(title: 'USC & Me'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Card(
              elevation: 4.0,
              margin: new EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Text(
                      "Schedule Service", )
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              margin: new EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Text("Snap A Pic & Get An Online Estimate")
                ],
              ),
            ),
            new Card(
              elevation: 4.0,
              margin: new EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Text("I Have An Emergency!")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
