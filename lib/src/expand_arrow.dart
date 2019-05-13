import 'package:flutter/material.dart';

class ExpandArrow extends StatefulWidget {
  final String minMessage, maxMessage;
  final Function onTap;
  final Color color;
  final double size;

  ExpandArrow({
    this.minMessage = 'Show more',
    this.maxMessage = 'Show less',
    @required this.onTap,
    this.color,
    this.size,
  });

  @override
  _ExpandArrowState createState() => _ExpandArrowState();
}

class _ExpandArrowState extends State<ExpandArrow> {
  bool _isMinimized = true;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: _message,
      child: InkResponse(
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Icon(
            _icon,
            color: widget.color ?? Theme.of(context).textTheme.caption.color,
            size: widget.size,
          ),
        ),
        onTap: () {
          _isMinimized = !_isMinimized;
          widget.onTap();
        },
      ),
    );
  }

  String get _message => _isMinimized ? widget.minMessage : widget.maxMessage;

  IconData get _icon => _isMinimized ? Icons.expand_more : Icons.expand_less;
}
