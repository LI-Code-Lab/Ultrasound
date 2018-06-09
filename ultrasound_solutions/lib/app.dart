import 'package:flutter/material.dart';
import 'package:ultrasound_solutions/views/backdrop_menu.dart';
import 'package:ultrasound_solutions/models/menu_option.dart';
import 'package:ultrasound_solutions/views/home_screen.dart';
import 'package:ultrasound_solutions/views/menu_screen.dart';
import 'package:ultrasound_solutions/models/colors.dart';

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
      theme: _buildTheme(),
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

ThemeData _buildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kUltraSoundOrange600,
    accentColor: kUltraSoundRed900,
    buttonColor: kUltraSoundOrange400,
    scaffoldBackgroundColor: kUltraSoundSurfaceWhite,
    cardColor: kUltraSoundBackgroundWhite,
    textSelectionColor: kUltraSoundOrange200,
    errorColor: kUltraSoundErrorRed,
    hintColor: kUltraSoundBackgroundWhite,
    buttonTheme: new ButtonThemeData(textTheme: ButtonTextTheme.accent),
    textTheme: _buildTextTheme(base.textTheme),
    primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildTextTheme(TextTheme base) {
  return base
      .copyWith(
    headline: base.headline.copyWith(
      fontWeight: FontWeight.w500,
    ),
    title: base.title.copyWith(fontSize: 18.0),
    caption: base.caption.copyWith(
      fontWeight: FontWeight.w400,
      fontSize: 14.0,
    ),
  ).apply(
    displayColor: Colors.red,
    bodyColor: Colors.white,
  );
}