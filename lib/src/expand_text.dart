import 'package:flutter/material.dart';

import 'expand_arrow.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// EXPAND TEXT WIDGET
/// This widget is used to show parcial text, if the text is too big for the parent size.
/// You can specify the [maxLenght] parameter. If the text is short enough,
/// no 'expand arrow' widget will be shown.
class ExpandText extends StatefulWidget {
  final String minMessage, maxMessage;
  final Color arrowColor;
  final double arrowSize;

  final Duration animationDuration;
  final String text;
  final int maxLength;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final bool expandWidth;
  final bool expandOnGesture;

  const ExpandText(
    this.text, {
    Key key,
    this.minMessage = 'Show more',
    this.maxMessage = 'Show less',
    this.arrowColor,
    this.arrowSize = 30,
    this.animationDuration = _kExpand,
    this.maxLength = 8,
    this.style,
    this.textAlign,
    this.overflow = TextOverflow.fade,
    this.expandWidth = false,
    this.expandOnGesture = true,
  }) : super(key: key);

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText>
    with TickerProviderStateMixin<ExpandText> {
  /// Custom animations curves for both height & arrow controll.
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  /// General animation controller.
  AnimationController _controller;

  /// Animation for controlling the height of the widget.
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

    /// Initializing the animation, depending on the [_easeInTween] curve.
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand arrow.
  void _handleTap([DragEndDetails dragDetails]) {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  /// Builds the widget itself. If the [_isExpanded] parameters is [true],
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChildren(BuildContext context, Widget child) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: widget.text,
          style: widget.style,
        ),
        textDirection: TextDirection.rtl,
        maxLines: widget.maxLength,
      )..layout(maxWidth: size.maxWidth);

      return textPainter.didExceedMaxLines
          ? Column(
              crossAxisAlignment: widget.expandWidth ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedSize(
                  vsync: this,
                  duration: widget.animationDuration,
                  alignment: Alignment.topCenter,
                  curve: Curves.easeInOutCubic,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(),
                    child: GestureDetector(
                      child: child,
                      onTap: widget.expandOnGesture ? _handleTap : null,
                      onVerticalDragEnd:
                          widget.expandOnGesture ? _handleTap : null,
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
            )
          : child;
    });
  }

  /// Returns the actual maximun number of allowed lines,
  /// depending on [_isExpanded].
  /// If [overflow] is set to ellipsis, it must not return null,
  /// otherwise the entire app could explode :)
  int _maxLines() {
    if (_isExpanded) {
      return (widget.overflow == TextOverflow.ellipsis) ? 2 ^ 64 : null;
    } else {
      return widget.maxLength;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: Text(
        widget.text,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        style: widget.style,
        maxLines: _maxLines(),
      ),
    );
  }
}
