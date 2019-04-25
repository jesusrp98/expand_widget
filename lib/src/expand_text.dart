import 'package:flutter/material.dart';

import 'expand_arrow.dart';

class ExpandText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle style;
  final TextAlign textAlign;

  ExpandText(
    this.text, {
    this.maxLength = 5,
    this.style,
    this.textAlign,
  });

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool _isMinimized = true;

  void toggleContent() => setState(() => _isMinimized = !_isMinimized);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter _textPainter = TextPainter(
        text: TextSpan(text: widget.text),
        textDirection: TextDirection.rtl,
        maxLines: widget.maxLength,
      )..layout(maxWidth: size.maxWidth);

      return _textPainter.didExceedMaxLines
          ? Column(children: <Widget>[
              Text(
                widget.text,
                textAlign: widget.textAlign,
                overflow: TextOverflow.fade,
                style: widget.style,
                maxLines: _isMinimized ? widget.maxLength : null,
              ),
              ExpandArrow(
                onTap: () => toggleContent(),
              )
            ])
          : Text(
              widget.text,
              textAlign: widget.textAlign,
              style: widget.style,
            );
    });
  }
}
