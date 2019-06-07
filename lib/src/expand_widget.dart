import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'expand_arrow.dart';

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
    this.arrowSize,
    this.animationDuration = const Duration(milliseconds: 300),
    @required this.child,
  }) : super(key: key);

  @override
  _ExpandChildState createState() => _ExpandChildState();
}

class _ExpandChildState extends State<ExpandChild>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
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
      builder: _buildChildren,
      child: widget.child,
    );
  }
}
