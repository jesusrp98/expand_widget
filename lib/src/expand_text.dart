import 'package:flutter/material.dart';

import 'expand_arrow.dart';

/// TEXT EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// It expands a [Text] widget, maxing its [maxLines] parameter.
class ExpandText extends StatefulWidget {
  final String text;
  final int maxLength;
  final TextStyle style;

  ExpandText({
    @required this.text,
    this.maxLength = 5,
    this.style,
  });

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool _isShort = true;

  void toggleContent() => setState(() => _isShort = !_isShort);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final TextPainter textPainter = TextPainter(
        text: TextSpan(text: widget.text),
        textDirection: TextDirection.rtl,
        maxLines: widget.maxLength,
      )..layout(maxWidth: size.maxWidth);
      final TextStyle textStyle = widget.style ??
          TextStyle(
            color: Theme.of(context).textTheme.caption.color,
            fontSize: 15,
          );

      return textPainter.didExceedMaxLines
          ? Column(children: <Widget>[
              Text(
                widget.text,
                textAlign: TextAlign.justify,
                overflow: TextOverflow.fade,
                style: textStyle,
                maxLines: _isShort ? widget.maxLength : null,
              ),
              _isShort
                  ? ExpandArrow.maximize(
                      message: '',
                      onTap: () => toggleContent(),
                    )
                  : ExpandArrow.minimize(
                      message: '',
                      onTap: () => toggleContent(),
                    )
            ])
          : Text(
              widget.text,
              textAlign: TextAlign.justify,
              style: textStyle,
            );
    });
  }
}
