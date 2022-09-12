import 'package:flutter/material.dart';

import 'expand_indicator.dart';
import 'indicator_builder.dart';

/// Default expand animation duration.
const _kExpandDuration = Duration(milliseconds: 2000);

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
  final Axis direction;

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

  /// Percentage of how much of the 'hidden' widget is show when collapsed.
  /// Defaults to `0.0`.
  final double collapsedVisibilityFactor;

  const ExpandChild({
    super.key,
    required this.child,
    this.animationDuration = _kExpandDuration,
    this.hideIndicatorOnExpand = false,
    this.direction = Axis.vertical,
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
    this.collapsedVisibilityFactor = 0,
  }) : assert(
          collapsedVisibilityFactor >= 0 && collapsedVisibilityFactor <= 1,
          'The parameter collapsedHeightFactor must lay between 0 and 1',
        );

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
    _expandFactor = _controller.drive(
      Tween(
        begin: widget.collapsedVisibilityFactor,
        end: 1.0,
      ).chain(_easeInCurve),
    );
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
    return Flex(
      direction: widget.direction,
      children: [
        _ExpandChildContent(
          value: _controller.value,
          direction: widget.direction,
          heightFactor:
              widget.direction == Axis.vertical ? _expandFactor.value : null,
          widthFactor:
              widget.direction == Axis.horizontal ? _expandFactor.value : null,
          child: child,
        ),
        _ExpandChildIndicator(
          heightIndicatorFactor:
              widget.hideIndicatorOnExpand ? 1 - _expandFactor.value : 1.0,
          child:
              widget.indicatorBuilder?.call(context, _handleTap, _isExpanded) ??
                  ExpandIndicator(
                    animation: _iconTurns,
                    expandIndicatorStyle: widget.expandIndicatorStyle,
                    onTap: _handleTap,
                    collapsedHint: widget.indicatorCollapsedHint,
                    expandedHint: widget.indicatorExpandedHint,
                    padding: widget.indicatorPadding,
                    iconColor: widget.indicatorIconColor,
                    iconSize: widget.indicatorIconSize,
                    icon: widget.direction == Axis.horizontal
                        ? Icons.chevron_right
                        : widget.indicatorIcon,
                    hintTextStyle: widget.indicatorHintTextStyle,
                    capitalizeHintText: widget.capitalizeIndicatorHintText,
                  ),
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

class _ExpandChildContent extends StatelessWidget {
  final double value;
  final Axis direction;
  final Widget? child;
  final double? heightFactor;
  final double? widthFactor;

  const _ExpandChildContent({
    required this.value,
    required this.direction,
    this.child,
    this.heightFactor,
    this.widthFactor,
  });

  Alignment get _childAlignment =>
      direction == Axis.horizontal ? Alignment.centerLeft : Alignment.topCenter;

  Alignment get _beginGradientAlignment =>
      direction == Axis.horizontal ? Alignment.centerLeft : Alignment.topCenter;

  Alignment get _endGradientAlignment => direction == Axis.horizontal
      ? Alignment.centerRight
      : Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: LinearGradient(
        colors: [Colors.white, Colors.white.withAlpha(0)],
        begin: _beginGradientAlignment,
        end: _endGradientAlignment,
        stops: [value, 1],
      ).createShader,
      child: ClipRect(
        child: Align(
          alignment: _childAlignment,
          heightFactor: heightFactor,
          widthFactor: widthFactor,
          child: child,
        ),
      ),
    );
  }
}

class _ExpandChildIndicator extends StatelessWidget {
  final double heightIndicatorFactor;
  final Widget child;

  const _ExpandChildIndicator({
    required this.heightIndicatorFactor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Align(
        heightFactor: heightIndicatorFactor,
        child: child,
      ),
    );
  }
}
