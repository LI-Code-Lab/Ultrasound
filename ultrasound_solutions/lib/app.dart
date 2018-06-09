import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/views/backdrop_menu.dart';
import 'package:ultrasound_solutions/models/menu_option.dart';
import 'package:ultrasound_solutions/views/home_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

  }
}

class AppState extends State<App> {
  @override
  Widget build(BuildContext context) {

  }

  Widget _buildApp(){
    return new MaterialApp(
      home: Backdrop(
        currentOption: MenuOption.Home,
        frontPanel: HomeScreen(),
        backPanel: Back,
      ),
    )
  }
}