import 'package:flutter/material.dart';

/// ICON EXPAND WIDGET
/// Auxiliary widget with allows user to expand a widget.
class ExpandArrow extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onTap;

  ExpandArrow({
    @required this.icon,
    @required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: InkResponse(
        child: Icon(icon, color: Theme.of(context).textTheme.caption.color),
        onTap: onTap,
      ),
    );
  }

  factory ExpandArrow.maximize({String message, VoidCallback onTap}) {
    return ExpandArrow(
      icon: Icons.expand_more,
      message: message,
      onTap: onTap,
    );
  }

  factory ExpandArrow.minimize({String message, VoidCallback onTap}) {
    return ExpandArrow(
      icon: Icons.expand_less,
      message: message,
      onTap: onTap,
    );
  }
}
