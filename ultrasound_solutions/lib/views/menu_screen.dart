import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ultrasound_solutions/models/menu_option.dart';
import 'package:ultrasound_solutions/models/colors.dart';

class MenuScreen extends StatelessWidget {
  final MenuOption currentOption;
  final ValueChanged<MenuOption> onOptionClick;
  final List<MenuOption> _categories = MenuOption.values;

  const MenuScreen({
    Key key,
    @required this.currentOption,
    this.onOptionClick,
  }) : assert(currentOption != null);

  @override
  Widget build(BuildContext context) {
    var menuOptions = <Widget>[];
    _categories.forEach((MenuOption menuOption){
      menuOptions.add(_buildOption(menuOption, context));
    });

    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 40.0),
        color: kUltraSoundOrange600,
        child: ListView(children: menuOptions),
      ),
    );
  }

  Widget _buildOption(MenuOption menuOption, BuildContext context) {
    var optionString =
      menuOption.toString().replaceAll('MenuOption.', '').toUpperCase();

    return GestureDetector(
      onTap: () => onOptionClick(menuOption),
      child: menuOption == currentOption
        ? Column(
        children: <Widget>[
          SizedBox(height: 16.0),
          Text(
            optionString,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14.0),
          Container(
            width: 70.0,
            height: 2.0,
            color: kUltraSoundRed900,
          ),
        ],
      ) :
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            optionString,
            textAlign: TextAlign.center,
          ),
        ),
    );
  }
}