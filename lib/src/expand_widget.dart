import 'package:flutter/material.dart';

import 'expand_icon.dart';

/// ROW EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// Those details are specified in the [child] variable.
class RowExpand extends StatefulWidget {
  final Widget child;

  RowExpand(this.child);

  @override
  _RowExpandState createState() => _RowExpandState();
}

class _RowExpandState extends State<RowExpand> {
  bool _isHide = true;

  void toggleContent() => setState(() => _isHide = !_isHide);

  @override
  Widget build(BuildContext context) {
    return _isHide
        ? IconExpand.maximize(
            message: '',
            onTap: () => toggleContent(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.child,
              IconExpand.minimize(
                message: '',
                onTap: () => toggleContent(),
              )
            ],
          );
  }
}
