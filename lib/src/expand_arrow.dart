import 'package:flutter/material.dart';

/// Render mode selection of the [ExpandArrow] widget.
enum ExpandArrowStyle {
  /// Only display an icon, tipically a [Icons.expand_more] icon.
  icon,

  /// Display just the text. It will be dependant on the widget state.
  text,

  /// Display both icon & text at the same tame, using a [Row] widget.
  both,
}

/// This widget is used in both [ExpandChild] & [ExpandText] widgets to show
/// the hidden information to the user. It posses an [animation] parameter.
/// Most widget parameters are customizable.
class ExpandArrow extends StatelessWidget {
  /// String used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String collapsedHint;

  /// String used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String expandedHint;

  /// Controlls the arrow's fluid(TM) animation for
  /// the arrow's rotation.
  final Animation<double> animation;

  /// Defines padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets padding;

  /// Callback to controll what happeds when the arrow is clicked.
  final void Function() onTap;

  /// Defines arrow's color.
  final Color arrowColor;

  /// Defines arrow's size. Default is [30].
  final double arrowSize;

  /// Icon that will be used instead of an arrow.
  /// Default is [Icons.expand_more].
  final IconData icon;

  /// Style of the displayed message.
  final TextStyle hintTextStyle;

  ///  Defines arrow rendering style. Default is [ExpandArrowStyle.icon].
  final ExpandArrowStyle expandArrowStyle;

  /// Autocapitalise tooltip text.
  final bool capitalArrowtext;

  const ExpandArrow({
    Key key,
    this.collapsedHint,
    this.expandedHint,
    @required this.animation,
    this.padding,
    this.onTap,
    this.arrowColor,
    this.arrowSize,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle,
    this.capitalArrowtext = true,
  })  : assert(animation != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final tooltipMessage = animation.value < 0.25
        ? collapsedHint ??
            MaterialLocalizations.of(context).collapsedIconTapHint
        : expandedHint ?? MaterialLocalizations.of(context).expandedIconTapHint;

    final isNotIcon = expandArrowStyle == ExpandArrowStyle.text ||
        expandArrowStyle == ExpandArrowStyle.both;

    final arrow = InkResponse(
      containedInkWell: isNotIcon,
      highlightShape: isNotIcon ? BoxShape.rectangle : BoxShape.circle,
      child: Padding(
        padding: padding ??
            EdgeInsets.all(expandArrowStyle == ExpandArrowStyle.text ? 8 : 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (expandArrowStyle != ExpandArrowStyle.text)
              RotationTransition(
                turns: animation,
                child: Icon(
                  icon ?? Icons.expand_more,
                  color:
                      arrowColor ?? Theme.of(context).textTheme.caption.color,
                  size: arrowSize ?? 30,
                ),
              ),
            if (isNotIcon) ...[
              const SizedBox(width: 2.0),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Theme.of(context).textTheme.caption.color,
                    ),
                child: Text(
                  capitalArrowtext == true
                      ? tooltipMessage.toUpperCase()
                      : tooltipMessage,
                  style: hintTextStyle,
                ),
              ),
              const SizedBox(width: 2.0),
            ]
          ],
        ),
      ),
      onTap: onTap,
    );

    return expandArrowStyle != ExpandArrowStyle.icon
        ? arrow
        : Tooltip(
            message: tooltipMessage,
            child: arrow,
          );
  }
}
