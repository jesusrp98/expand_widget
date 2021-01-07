import 'package:flutter/material.dart';

import 'expand_arrow.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// This widget unfolds a hidden widget to the user, called [child].
/// This action is performed when the user clicks the 'expand' arrow.
class ExpandChild extends StatefulWidget {
  /// Message used as a tooltip when the widget is minimized.
  /// Default value set to [MaterialLocalizations.of(context).collapsedIconTapHint].
  final String collapsedHint;

  /// Message used as a tooltip when the widget is maximazed.
  /// Default value set to [MaterialLocalizations.of(context).expandedIconTapHint].
  final String expandedHint;

  /// Defines padding value.
  ///
  /// Default value if this widget's icon-only: [EdgeInsets.all(4)].
  /// If text is shown: [EdgeInsets.all(8)].
  final EdgeInsets arrowPadding;

  /// Color of the arrow widget. Defaults to the caption text style color.
  final Color arrowColor;

  /// Size of the arrow widget. Default is [30].
  final double arrowSize;

  /// Icon that will be used instead of an arrow.
  /// Default is [Icons.expand_more].
  final IconData icon;

  /// Style of the displayed message.
  final TextStyle hintTextStyle;

  /// Defines arrow rendering style.
  final ExpandArrowStyle expandArrowStyle;

  /// Autocapitalise tooltip text.
  final bool capitalArrowtext;

  /// How long the expanding animation takes. Default is 300ms.
  final Duration animationDuration;

  /// This widget will be displayed if the user clicks the 'expand' arrow.
  final Widget child;

  /// Ability to hide arrow from display when content is expanded.
  final bool hideArrowOnExpanded;

  // Whether to expand vertically, or horizontally (= false)
  final bool vertical;

  const ExpandChild({
    Key key,
    this.collapsedHint,
    this.expandedHint,
    this.arrowPadding,
    this.arrowColor,
    this.arrowSize = 30,
    this.icon,
    this.hintTextStyle,
    this.expandArrowStyle = ExpandArrowStyle.icon,
    this.capitalArrowtext = true,
    this.animationDuration = _kExpand,
    @required this.child,
    this.hideArrowOnExpanded = false,
    this.vertical = true,
  })  : assert(hideArrowOnExpanded != null),
        super(key: key);

  @override
  _ExpandChildState createState() => _ExpandChildState();
}

class _ExpandChildState extends State<ExpandChild>
    with SingleTickerProviderStateMixin {
  /// Custom animation curve for arrow controll.
  static final _easeInCurve = CurveTween(curve: Curves.easeInOutCubic);

  /// Controlls the rotation of the arrow widget.
  static final _halfTurn = Tween<double>(begin: 0.0, end: 0.5);

  /// General animation controller.
  AnimationController _controller;

  /// Animations for height/width control.
  Animation<double> _expandFactor;

  /// Animations for arrow's rotation control.
  Animation<double> _iconTurns;

  /// Auxiliary variable to controll expand status.
  bool _isExpanded = false;

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

  /// Method called when the user clicks on the expand arrow
  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  /// Builds the widget itself. If the [_isExpanded] parameter is 'true',
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChild(BuildContext context, Widget child) {
    return widget.vertical
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                  heightFactor:
                      widget.hideArrowOnExpanded ? 1 - _expandFactor.value : 1,
                  child: InkWell(
                    onTap: _handleTap,
                    child: ExpandArrow(
                      collapsedHint: widget.collapsedHint,
                      expandedHint: widget.expandedHint,
                      animation: _iconTurns,
                      padding: widget.arrowPadding,
                      onTap: _handleTap,
                      arrowColor: widget.arrowColor,
                      arrowSize: widget.arrowSize,
                      icon: widget.icon,
                      hintTextStyle: widget.hintTextStyle,
                      expandArrowStyle: widget.expandArrowStyle,
                      capitalArrowtext: widget.capitalArrowtext,
                    ),
                  ),
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
                children: <Widget>[
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
                      widthFactor: widget.hideArrowOnExpanded
                          ? 1 - _expandFactor.value
                          : 1,
                      child: InkWell(
                        onTap: _handleTap,
                        child: ExpandArrow(
                          collapsedHint: widget.collapsedHint,
                          expandedHint: widget.expandedHint,
                          animation: _iconTurns,
                          padding: widget.arrowPadding,
                          onTap: _handleTap,
                          arrowColor: widget.arrowColor,
                          arrowSize: widget.arrowSize,
                          icon: widget.icon ?? Icons.chevron_right,
                          hintTextStyle: widget.hintTextStyle,
                          expandArrowStyle: widget.expandArrowStyle,
                          capitalArrowtext: widget.capitalArrowtext,
                        ),
                      ),
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
