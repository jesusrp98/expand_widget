import 'package:flutter/material.dart';

class ExpandArrow extends StatefulWidget {
  final String minMessage, maxMessage;
  final Animation<double> animation;
  final Function onTap;
  final Color color;
  final double size;

  ExpandArrow({
    this.minMessage,
    this.maxMessage,
    @required this.animation,
    @required this.onTap,
    this.color,
    this.size,
  });

  @override
  _ExpandArrowState createState() => _ExpandArrowState();
}

class _ExpandArrowState extends State<ExpandArrow> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _message,
      child: InkResponse(
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: RotationTransition(
            turns: widget.animation,
            child: Icon(
              Icons.expand_more,
              color: widget.color ?? Theme.of(context).textTheme.caption.color,
              size: widget.size,
            ),
          ),
        ),
        onTap: widget.onTap,
      ),
    );
  }

  String get _message =>
      widget.animation.value == 0 ? widget.minMessage : widget.maxMessage;
}
