import 'package:flutter/material.dart';

import 'expand_arrow.dart';

/// Default animation duration
const Duration _kExpand = Duration(milliseconds: 300);

/// This widget is used to show parcial text, if the text is too big for the parent size.
/// You can specify the [maxLines] parameter. If the text is short enough,
/// no 'expand arrow' widget will be shown.
class ExpandText extends StatefulWidget {
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

  /// Text that will be displayed.
  final String data;

  /// Maximun number of lines the widget shows when it's minimized. Default is 8.
  final int maxLines;

  /// Corresponds to the style parameter of the text view.
  final TextStyle style;

  /// Corresponds to the aling parameter of the text view.
  final TextAlign textAlign;

  /// Corresponds to the overflow parameter of the text view. Default is 'fade'.
  final TextOverflow overflow;

  /// Related to the width the widget should occupy.
  /// If 'true' it will stretch out, using all the available horizontal space.
  /// Otherwise the text widget will be centered inside its parent widget.
  /// Default is false.
  final bool expandWidth;

  /// Wheter the text view should expand/retract if the user drags on it. Default is 'true'.
  final bool expandOnGesture;

  /// Ability to hide arrow from display when content is expanded.
  final bool hideArrowOnExpanded;

  const ExpandText(
    this.data, {
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
    this.maxLines = 8,
    this.style,
    this.textAlign,
    this.overflow = TextOverflow.fade,
    this.expandWidth = false,
    this.expandOnGesture = true,
    this.hideArrowOnExpanded = false,
  })  : assert(
          data != null,
          'A non-null String must be provided to a ExpandText widget.',
        ),
        assert(expandWidth != null),
        assert(expandOnGesture != null),
        assert(hideArrowOnExpanded != null),
        super(key: key);

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText>
    with TickerProviderStateMixin<ExpandText> {
  /// Custom animation curve for arrow controll.
  static final _easeInCurve = CurveTween(curve: Curves.easeInOutCubic);

  /// Controlls the rotation of the arrow widget.
  static final _halfTurn = Tween<double>(begin: 0.0, end: 0.5);

  /// General animation controller.
  AnimationController _controller;

  /// Animations for height control.
  Animation<double> _heightFactor;

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

    // Initializing the animation, depending on the [_easeInCurve] curve
    _heightFactor = _controller.drive(_easeInCurve);
    _iconTurns = _controller.drive(_halfTurn.chain(_easeInCurve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Method called when the user clicks on the expand arrow,
  /// clicks or drags on the child text view.
  void _handleTap([DragEndDetails dragDetails]) {
    setState(() {
      // If the user dragged the content
      if (dragDetails != null) {
        // If the drag finishes with some velocity
        // If not, no text expansion will be performed
        if (dragDetails.primaryVelocity != 0) {
          _isExpanded = dragDetails.primaryVelocity > 0;
          dragDetails.primaryVelocity > 0
              ? _controller.forward()
              : _controller.reverse();
        }
      } else {
        _isExpanded = !_isExpanded;
        _isExpanded ? _controller.forward() : _controller.reverse();
      }
    });
  }

  /// Builds the widget itself. If the [_isExpanded] parameter is 'true',
  /// the [child] parameter will contain the child information, passed to
  /// this instance of the object.
  Widget _buildChildren(BuildContext context, Widget child) {
    return LayoutBuilder(builder: (context, size) {
      final Text textWidget = child as Text;
      final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
      TextStyle effectiveTextStyle = textWidget.style;
      if (textWidget.style == null || textWidget.style.inherit)
        effectiveTextStyle = defaultTextStyle.style.merge(textWidget.style);
      if (MediaQuery.boldTextOverride(context))
        effectiveTextStyle = effectiveTextStyle
            .merge(const TextStyle(fontWeight: FontWeight.bold));

      final textPainter = TextPainter(
        text: TextSpan(
          text: widget.data,
          style: effectiveTextStyle,
        ),
        textDirection: TextDirection.ltr,
        maxLines: widget.maxLines,
      )..layout(maxWidth: size.maxWidth);

      return textPainter.didExceedMaxLines
          ? Column(
              crossAxisAlignment: widget.expandWidth
                  ? CrossAxisAlignment.stretch
                  : CrossAxisAlignment.center,
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
                ClipRect(
                  child: Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      heightFactor: widget.hideArrowOnExpanded
                          ? 1 - _heightFactor.value
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
                          icon: widget.icon,
                          hintTextStyle: widget.hintTextStyle,
                          expandArrowStyle: widget.expandArrowStyle,
                          capitalArrowtext: widget.capitalArrowtext,
                        ),
                      ),
                    ),
                  ),
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
  int get _maxLines {
    if (_isExpanded) {
      return (widget.overflow == TextOverflow.ellipsis) ? 2 ^ 64 : null;
    } else {
      return widget.maxLines;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: Text(
        widget.data,
        textAlign: widget.textAlign,
        overflow: widget.overflow,
        style: widget.style,
        maxLines: _maxLines,
      ),
    );
  }
}
