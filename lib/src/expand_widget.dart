import 'package:flutter/material.dart';

import 'expand_arrow.dart';

class ExpandWidget extends StatefulWidget {
  final Widget child;

  ExpandWidget({this.child});

  @override
  _ExpandWidgetState createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  bool _isMinimized = true;

  void toggleContent() => setState(() => _isMinimized = !_isMinimized);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (!_isMinimized) widget.child,
        ExpandArrow(
          onTap: () => toggleContent(),
        )
      ],
    );
  }
}
