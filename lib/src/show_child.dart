import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// SHOW CHILD WIDGET
/// This widget unfolds a hidden widget to the user, called [child].
/// The main difference with [ExpandChild] is that, once expanded,
/// the user can't hide once again.
class ShowChild extends StatefulWidget {
  final Widget indicator, child;
  final Duration animationDuration;

  const ShowChild({
    Key key,
    this.animationDuration = _kExpand,
    @required this.indicator,
    @required this.child,
  }) : super(key: key);

  @override
  _ShowChildState createState() => _ShowChildState();
}

class _ShowChildState extends State<ShowChild>
    with SingleTickerProviderStateMixin {
  /// Custom animations curves for height controll.
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);

  /// General animation controller.
  AnimationController _controller;

  /// Animations for height control.
  Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    /// Initializing the animation controller with the [duration] parameter.
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    /// Initializing both animations, depending on the [_easeInTween] curve.
    _heightFactor = _controller.drive(_easeInTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand widget.
  void _handleTap() {
    setState(() {
      _isExpanded = true;
      _controller.forward();
    });
  }

  /// Builds the widget itself. If the [_isExpanded] parameters is [true],
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChild(BuildContext context, Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactor.value,
            child: child,
          ),
        ),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1 - _heightFactor.value,
            child: InkWell(
              child: widget.indicator,
              onTap: _handleTap,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChild,
      child: widget.child,
    );
  }
}
