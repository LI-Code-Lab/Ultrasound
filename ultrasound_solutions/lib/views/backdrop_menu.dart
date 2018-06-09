import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:ultrasound_solutions/models/menu_option.dart';

const double _kFlingVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final MenuOption currentOption;
  final Widget frontPanel;
  final Widget backPanel;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    @required this.currentOption,
    @required this.frontPanel,
    @required this.backPanel,
    @required this.frontTitle,
    @required this.backTitle,
  }) : assert(currentOption != null),
       assert(frontPanel != null),
       assert(backPanel != null),
       assert(frontTitle != null),
       assert(backTitle != null);

  @override
  State<StatefulWidget> createState() {
    return new BackdropState();
  }
}

class BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {

  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: LayoutBuilder(builder: _buildStack),
    );
  }

  Widget _buildAppBar(){
    return new AppBar(
      brightness: Brightness.light,
      elevation: 0.0,
      leading: IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.close_menu,
          progress: _controller.view,
        ),
        onPressed: _toggleBackdropPanelVisibility,
      ),
      title: Text('USC & Me'),
    );
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(
      velocity: _backdropPanelVisible ? -_kFlingVelocity : _kFlingVelocity);
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints){
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    Animation<RelativeRect> panelAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
        0.0, panelTop, 0.0, panelTop - panelSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      ).animate(_controller.view);

    return Container(
      key: _backdropKey,
      child: Stack(
        children: <Widget>[
          widget.backPanel,
          PositionedTransition(
            rect: panelAnimation,
            child: BackDropPanel(
              child: widget.frontPanel,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(microseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class BackDropPanel extends StatelessWidget {
  final Widget child;

  const BackDropPanel({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 16.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: child,
          )
        ],
      ),
    );
  }
}