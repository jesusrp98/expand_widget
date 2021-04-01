import 'package:flutter/material.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// This widget is now considered as **deprecated**, you should not use it.
///
/// In order to get the same functionallity offered by this widget,
/// just use a regular `ExpandChild` widget, with the `expandArrowStyle`
/// property set to `ExpandArrowStyle.text`, and `hideArrowOnExpanded`
/// set to `true`.
///
/// \---
///
/// This widget unfolds a hidden widget to the user, called [child].
/// The main difference with [ExpandChild] is that, once expanded,
/// the user can't hide once again.
@deprecated
class ShowChild extends StatefulWidget {
  /// How long the expanding animation takes. Default is 300ms.
  final Duration animationDuration;

  /// Widget that the user interacts with, in order to show the [child] widget.
  final Widget indicator;

  /// This widget will be displayed if the user clicks the [indicator] widget.
  final Widget child;

  const ShowChild({
    Key? key,
    this.animationDuration = _kExpand,
    required this.indicator,
    required this.child,
  }) : super(key: key);

  @override
  _ShowChildState createState() => _ShowChildState();
}

@deprecated
class _ShowChildState extends State<ShowChild>
    with SingleTickerProviderStateMixin {
  /// Custom animation curve for arrow controll.
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);

  /// General animation controller.
  late AnimationController _controller;

  /// Animations for height control.
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();

    // Initializing the animation controller with the [duration] parameter
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    // Initializing both animations, depending on the [_easeInTween] curve
    _heightFactor = _controller.drive(_easeInTween);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand widget
  void _handleTap() {
    setState(() {
      _controller.forward();
    });
  }

  Widget _buildChild(BuildContext context, Widget? child) {
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
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: 1 - _heightFactor.value,
            child: InkWell(
              child: widget.indicator,
              onTap: _handleTap,
            ),
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
