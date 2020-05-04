import 'package:flutter/material.dart';

/// This widget is used in both [ExpandChild] & [ExpandText] widgets to show
/// the hidden information to the user. It posses an [animation] parameter.
/// Most widget parameters, such as [size] & [color] are customizable.
class ExpandArrow extends StatelessWidget {
  /// Message used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String minMessage;

  /// Message used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String maxMessage;

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

  const ExpandArrow({
    Key key,
    this.minMessage,
    this.maxMessage,
    @required this.animation,
    this.padding,
    @required this.onTap,
    this.color,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String minMessageText =
        minMessage ?? MaterialLocalizations.of(context).collapsedIconTapHint;
    final String maxMessageText =
        minMessage ?? MaterialLocalizations.of(context).expandedIconTapHint;

    return Padding(
      padding: padding ?? EdgeInsets.all(4),
      child: Tooltip(
        message: animation.value == 0 ? minMessageText : maxMessageText,
        child: InkResponse(
          child: RotationTransition(
            turns: animation,
            child: Icon(
              Icons.expand_more,
              color: color ?? Theme.of(context).textTheme.caption.color,
              size: size,
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
