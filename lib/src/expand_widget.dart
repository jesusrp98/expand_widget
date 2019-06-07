import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExpandWidget extends StatefulWidget {
  final Duration animationDuration;
  final Widget child;

  const ExpandWidget({
    Key key,
    this.animationDuration = const Duration(milliseconds: 350),
    @required this.child,
  }) : super(key: key);

  @override
  _ExpandWidgetState createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeInOutCubic);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _heightFactor;
  Animation<double> _iconTurns;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  Widget _buildChildren(BuildContext context, Widget child) {
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
        Tooltip(
          message: _isExpanded ? 'Show less' : 'Show more',
          child: InkResponse(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: RotationTransition(
                turns: _iconTurns,
                child: Icon(
                  Icons.expand_more,
                  size: null,
                  color: Theme.of(context).textTheme.caption.color,
                ),
              ),
            ),
            onTap: _handleTap,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: widget.child,
    );
  }
}
