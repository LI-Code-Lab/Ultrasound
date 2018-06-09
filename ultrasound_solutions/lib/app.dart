import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/views/backdrop_menu.dart';
import 'package:ultrasound_solutions/models/menu_option.dart';
import 'package:ultrasound_solutions/views/home_screen.dart';
import 'package:ultrasound_solutions/views/menu_screen.dart';

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AppState();
  }
}

class AppState extends State<App> {
  MenuOption _currentOption = MenuOption.Home;

  @override
  Widget build(BuildContext context) {
    return _buildApp();
  }

  Widget _buildApp(){
    return new MaterialApp(
      home: Backdrop(
        currentOption: MenuOption.Home,
        frontPanel: HomeScreen(),
        backPanel: MenuScreen(
          currentOption: _currentOption,
          onOptionClick: _onOptionClicked,
        ),
        frontTitle: Text('USC & Me'),
        backTitle: Text("Menu"),
      ),
    );
  }

  void _onOptionClicked(MenuOption option){
    setState(() {
      _currentOption = option;
    });
  }
}