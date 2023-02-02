import 'package:flutter/material.dart';

/// Render mode selection of the `ExpandArrow` widget.
enum ExpandIndicatorStyle {
  /// Only display an icon, tipically a [Icons.expand_more] icon.
  icon,

  /// Display just the text. It will be dependant on the widget state.
  text,

  /// Display both icon & text at the same tame, using a [Row] widget.
  both,
}

/// This widget is used in both `ExpandChild` & `ExpandText` widgets to show
/// the hidden information to the user. It posses an [animation] parameter.
/// Most widget parameters are customizable.
class ExpandIndicator extends StatelessWidget {
  /// Controlls the indicator's fluid(TM) animation for
  /// the icon's rotation.
  final Animation<double> animation;

  /// Defines indicator rendering style.
  final ExpandIndicatorStyle expandIndicatorStyle;

  /// Callback to controll what happeds when the indicator is clicked.
  final VoidCallback? onTap;

  /// String used as a tooltip when the widget is minimized.
  /// Default value set
  /// to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String? collapsedHint;

  /// String used as a tooltip when the widget is maximazed.
  /// Default value set
  /// to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String? expandedHint;

  /// Defines indicator padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets? padding;

  /// Defines indicator icon's color. Defaults to the caption text style color.
  final Color? iconColor;

  /// Defines icon's size. Default is [24].
  final double? iconSize;

  /// Icon that will be used for the indicator.
  /// Default is [Icons.expand_more].
  final IconData? icon;

  /// Style of the displayed message.
  final TextStyle? hintTextStyle;

  /// Autocapitalise tooltip text. Defaults to `true`.
  final bool capitalizeHintText;

  const ExpandIndicator({
    super.key,
    required this.animation,
    required this.expandIndicatorStyle,
    this.onTap,
    this.collapsedHint,
    this.expandedHint,
    this.padding,
    this.iconColor,
    this.iconSize,
    this.icon,
    this.hintTextStyle,
    this.capitalizeHintText = true,
  });

  @override
  Widget build(BuildContext context) {
    final tooltipMessage = animation.value < 0.25
        ? collapsedHint ??
            MaterialLocalizations.of(context).collapsedIconTapHint
        : expandedHint ?? MaterialLocalizations.of(context).expandedIconTapHint;

    final isNotIcon = expandIndicatorStyle == ExpandIndicatorStyle.text ||
        expandIndicatorStyle == ExpandIndicatorStyle.both;

    final indicator = InkResponse(
      containedInkWell: isNotIcon,
      highlightShape: isNotIcon ? BoxShape.rectangle : BoxShape.circle,
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: Padding(
        padding: padding ??
            EdgeInsets.all(
              expandIndicatorStyle == ExpandIndicatorStyle.text ? 8 : 4,
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (expandIndicatorStyle != ExpandIndicatorStyle.text)
              RotationTransition(
                turns: animation,
                child: Icon(
                  icon ?? Icons.expand_more_rounded,
                  color:
                      iconColor ?? Theme.of(context).textTheme.bodySmall?.color,
                  size: iconSize,
                ),
              ),
            if (isNotIcon) ...[
              const SizedBox(width: 2),
              DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                child: Text(
                  capitalizeHintText
                      ? tooltipMessage.toUpperCase()
                      : tooltipMessage,
                  style: hintTextStyle,
                ),
              ),
              const SizedBox(width: 2),
            ]
          ],
        ),
      ),
    );

    return expandIndicatorStyle != ExpandIndicatorStyle.icon
        ? indicator
        : Tooltip(
            message: tooltipMessage,
            child: indicator,
          );
  }
}
