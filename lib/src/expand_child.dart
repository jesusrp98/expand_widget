import 'package:flutter/material.dart';

import 'expand_indicator.dart';
import 'indicator_builder.dart';

/// Default expand animation duration.
const _kExpandDuration = Duration(milliseconds: 300);

/// This widget unfolds a hidden widget to the user, called [child].
/// This action is performed when the user clicks the 'expand' indicator.
class ExpandChild extends StatefulWidget {
  /// This widget will be displayed if the user clicks the 'expand' indicator.
  final Widget child;

  /// How long the expanding animation takes. Default is 300ms.
  final Duration animationDuration;

  /// Ability to hide indicator from display when content is expanded.
  /// Defaults to `false`.
  final bool hideIndicatorOnExpand;

  /// Direction of exapnsion, vertical by default.
  final Axis expandDirection;

  /// Method to override the [ExpandIndicator] widget for expanding the content.
  final IndicatorBuilder? indicatorBuilder;

  /// Defines indicator rendering style.
  final ExpandIndicatorStyle expandIndicatorStyle;

  /// Message used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String? indicatorCollapsedHint;

  /// Message used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String? indicatorExpandedHint;

  /// Defines indicator padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets? indicatorPadding;

  /// Defines indicator icon's color. Defaults to the caption text style color.
  final Color? indicatorIconColor;

  /// Defines icon's size. Default is [24].
  final double? indicatorIconSize;

  /// Icon that will be used for the indicator.
  /// Default is [Icons.expand_more].
  final IconData? indicatorIcon;

  /// Style of the displayed message.
  final TextStyle? indicatorHintTextStyle;

  /// Autocapitalise tooltip text. Defaults to `true`.
  final bool capitalizeIndicatorHintText;

  const ExpandChild({
    super.key,
    required this.child,
    this.animationDuration = _kExpandDuration,
    this.hideIndicatorOnExpand = false,
    this.expandDirection = Axis.vertical,
    this.indicatorBuilder,
    this.expandIndicatorStyle = ExpandIndicatorStyle.icon,
    this.indicatorCollapsedHint,
    this.indicatorExpandedHint,
    this.indicatorPadding,
    this.indicatorIconColor,
    this.indicatorIconSize,
    this.indicatorIcon,
    this.indicatorHintTextStyle,
    this.capitalizeIndicatorHintText = true,
  });

  @override
  State<StatefulWidget> createState() => _ExpandChildState();
}

class _ExpandChildState extends State<ExpandChild>
    with SingleTickerProviderStateMixin {
  /// Custom animation curve for indicator icon controll.
  static final _easeInCurve = CurveTween(curve: Curves.easeInOutCubic);

  /// Controlls the rotation of the indicator icon widget.
  static final _halfTurn = Tween(begin: 0.0, end: 0.5);

  /// General animation controller.
  late AnimationController _controller;

  /// Animations for height/width control.
  late Animation<double> _expandFactor;

  /// Animations for indicator icon's rotation control.
  late Animation<double> _iconTurns;

  /// Auxiliary variable to controll expand status.
  var _isExpanded = false;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with the [duration] parameter
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Initializing both animations, depending on the [_easeInCurve] curve
    _expandFactor = _controller.drive(_easeInCurve);
    _iconTurns = _controller.drive(_halfTurn.chain(_easeInCurve));
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  /// Method called when the user clicks on the expand indicator
  void _handleTap() => setState(() {
        _isExpanded = !_isExpanded;
        _isExpanded ? _controller.forward() : _controller.reverse();
      });

  /// Builds the widget itself. If the [_isExpanded] parameter is 'true',
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChild(BuildContext context, Widget? child) {
    final heightIndicatorFactor =
        widget.hideIndicatorOnExpand ? 1 - _expandFactor.value : 1.0;

    final indicator = widget.indicatorBuilder != null
        ? widget.indicatorBuilder!(context, _handleTap, _isExpanded)
        : ExpandIndicator(
            animation: _iconTurns,
            expandIndicatorStyle: widget.expandIndicatorStyle,
            onTap: _handleTap,
            collapsedHint: widget.indicatorCollapsedHint,
            expandedHint: widget.indicatorExpandedHint,
            padding: widget.indicatorPadding,
            iconColor: widget.indicatorIconColor,
            iconSize: widget.indicatorIconSize,
            icon: widget.indicatorIcon ??
                (widget.expandDirection == Axis.horizontal
                    ? Icons.chevron_right
                    : null),
            hintTextStyle: widget.indicatorHintTextStyle,
            capitalizeHintText: widget.capitalizeIndicatorHintText,
          );

    return widget.expandDirection == Axis.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: _expandFactor.value,
                  child: child,
                ),
              ),
              ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: heightIndicatorFactor,
                  child: indicator,
                ),
              ),
            ],
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      widthFactor: _expandFactor.value,
                      child: child,
                    ),
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: heightIndicatorFactor,
                      child: indicator,
                    ),
                  ),
                ],
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
