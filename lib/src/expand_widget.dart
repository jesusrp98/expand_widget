import 'package:flutter/material.dart';

import 'expand_arrow.dart';

/// ROW EXPAND WIDGET
/// Stateful widget, which when tapped, opens more details.
/// Those details are specified in the [child] variable.
class ExpandWidget extends StatefulWidget {
  final Widget child;

  ExpandWidget(this.child);

  @override
  _ExpandWidgetState createState() => _ExpandWidgetState();
}

class _ExpandWidgetState extends State<ExpandWidget> {
  bool _isHide = true;

  void toggleContent() => setState(() => _isHide = !_isHide);

  @override
  Widget build(BuildContext context) {
    return _isHide
        ? ExpandArrow.maximize(
            message: '',
            onTap: () => toggleContent(),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              widget.child,
              ExpandArrow.minimize(
                message: '',
                onTap: () => toggleContent(),
              )
            ],
          );
  }
}
