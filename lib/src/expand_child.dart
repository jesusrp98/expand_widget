import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'expand_arrow.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// EXPAND CHILD WIDGET
/// This widget unfolds a hidden widget to the user, called [child].
class ExpandChild extends StatefulWidget {
  final String minMessage, maxMessage;
  final Color arrowColor;
  final double arrowSize;

  final Duration animationDuration;
  final Widget child;

  const ExpandChild({
    Key key,
    this.minMessage = 'Show more',
    this.maxMessage = 'Show less',
    this.arrowColor,
    this.arrowSize = 30,
    this.animationDuration = _kExpand,
    @required this.child,
  }) : super(key: key);

  @override
  _ExpandChildState createState() => _ExpandChildState();
}

class _ExpandChildState extends State<ExpandChild>
    with SingleTickerProviderStateMixin {
  /// Custom animations curves for both height & arrow controll.
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  /// General animation controller.
  AnimationController _controller;

  /// Animations for both height & arrow control.
  Animation<double> _heightFactor;
  Animation<double> _iconTurns;

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
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand arrow.
  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
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
        ExpandArrow(
          minMessage: widget.minMessage,
          maxMessage: widget.maxMessage,
          color: widget.arrowColor,
          size: widget.arrowSize,
          animation: _iconTurns,
          onTap: _handleTap,
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
