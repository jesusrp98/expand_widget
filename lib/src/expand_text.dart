import 'package:flutter/material.dart';

import 'expand_arrow.dart';

const Duration _kExpand = Duration(milliseconds: 300);

class ExpandText extends StatefulWidget {
  final String minMessage, maxMessage;
  final Color arrowColor;
  final double arrowSize;

  final Duration animationDuration;
  final String text;
  final int maxLength;
  final TextStyle style;
  final TextAlign textAlign;

  const ExpandText(
    this.text, {
    Key key,
    this.minMessage = 'Show more',
    this.maxMessage = 'Show less',
    this.arrowColor,
    this.arrowSize,
    this.animationDuration = _kExpand,
    this.maxLength = 5,
    this.style,
    this.textAlign,
  }) : super(key: key);

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText>
    with TickerProviderStateMixin<ExpandText> {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
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
        AnimatedSize(
          vsync: this,
          duration: widget.animationDuration,
          curve: Curves.easeInOutCubic,
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: child,
            ),
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
      child: Text(
        widget.text,
        textAlign: widget.textAlign,
        overflow: TextOverflow.fade,
        style: widget.style,
        maxLines: _isExpanded ? null : widget.maxLength,
      ),
    );
  }
}
