import 'package:flutter/material.dart';

/// This widget is used in both [ExpandChild] & [ExpandText] widgets to show
/// the hidden information to the user. It posses an [animation] parameter.
/// Most widget parameters, such as [size] & [color] are customizable.
class ExpandArrow extends StatelessWidget {
  /// Message used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String collapsedHint;

  /// Message used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String expandedHint;

  /// Controlls the arrow fluid(TM) animation.
  final Animation<double> animation;

  /// Defines padding value.
  final EdgeInsets padding;

  /// Callback to controll what happeds when the arrow is clicked.
  final VoidCallback onTap;

  /// Defines arrow's color.
  final Color color;

  /// Defines arrow's size.
  final double size;

  /// Style of the displayed message.
  final TextStyle hintTextStyle;

  /// Defines arrow rendering style.
  final bool displayHintText;

  const ExpandArrow({
    Key key,
    this.collapsedHint,
    this.expandedHint,
    @required this.animation,
    this.padding,
    @required this.onTap,
    this.color,
    this.size,
    this.hintTextStyle,
    this.displayHintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipMessage = animation.value == 0
        ? collapsedHint ??
            MaterialLocalizations.of(context).collapsedIconTapHint
        : expandedHint ?? MaterialLocalizations.of(context).expandedIconTapHint;

    final animatedArrow = RotationTransition(
      turns: animation,
      child: Icon(
        Icons.expand_more,
        color: color ?? Theme.of(context).textTheme.caption.color,
        size: size,
      ),
    );

    return Padding(
      padding: padding ?? EdgeInsets.all(4),
      child: Tooltip(
        message: tooltipMessage,
        child: displayHintText == true
            ? InkWell(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    animatedArrow,
                    const SizedBox(width: 8.0),
                    Text(
                      tooltipMessage,
                      style: hintTextStyle,
                    ),
                    const SizedBox(width: 8.0),
                  ],
                ),
                onTap: onTap,
              )
            : InkResponse(
                child: animatedArrow,
                onTap: onTap,
              ),
      ),
    );
  }
}
