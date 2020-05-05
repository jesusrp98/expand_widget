import 'package:flutter/material.dart';

/// TODO
enum ExpandArrowStyle {
  ///
  icon,

  ///
  text,

  ///
  both,
}

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

  /// Icon that will be used instead of an arrow.
  final IconData icon;

  /// Style of the displayed message.
  final TextStyle hintTextStyle;

  /// Defines arrow rendering style.
  final bool displayHintText;

  /// TODO
  final ExpandArrowStyle expandArrowStyle;

  const ExpandArrow({
    Key key,
    this.collapsedHint,
    this.expandedHint,
    @required this.animation,
    this.padding,
    @required this.onTap,
    this.color,
    this.size,
    this.icon,
    this.hintTextStyle,
    this.displayHintText,
    this.expandArrowStyle = ExpandArrowStyle.both,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipMessage = animation.value <= 0.25
        ? collapsedHint ??
            MaterialLocalizations.of(context).collapsedIconTapHint
        : expandedHint ?? MaterialLocalizations.of(context).expandedIconTapHint;

    final animatedArrow = RotationTransition(
      turns: animation,
      child: Icon(
        icon ?? Icons.expand_more,
        color: color ?? Theme.of(context).textTheme.caption.color,
        size: size,
      ),
    );

    return Tooltip(
      message: tooltipMessage,
      child: InkResponse(
        containedInkWell: expandArrowStyle != ExpandArrowStyle.icon,
        highlightShape: expandArrowStyle != ExpandArrowStyle.icon
            ? BoxShape.rectangle
            : BoxShape.circle,
        child: Padding(
          padding: padding ??
              EdgeInsets.all(expandArrowStyle == ExpandArrowStyle.text ? 8 : 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (expandArrowStyle != ExpandArrowStyle.text) animatedArrow,
              if (expandArrowStyle != ExpandArrowStyle.icon) ...[
                const SizedBox(width: 2.0),
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                  child: Text(
                    tooltipMessage.toUpperCase(),
                    style: hintTextStyle,
                  ),
                ),
                const SizedBox(width: 2.0),
              ]
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
