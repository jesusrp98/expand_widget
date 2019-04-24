import 'package:flutter/material.dart';

/// ICON EXPAND WIDGET
/// Auxiliary widget with allows user to expand a widget.
class IconExpand extends StatelessWidget {
  final IconData icon;
  final String message;
  final VoidCallback onTap;

  IconExpand({
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

  factory IconExpand.maximize({String message, VoidCallback onTap}) {
    return IconExpand(
      icon: Icons.expand_more,
      message: message,
      onTap: onTap,
    );
  }

  factory IconExpand.minimize({String message, VoidCallback onTap}) {
    return IconExpand(
      icon: Icons.expand_less,
      message: message,
      onTap: onTap,
    );
  }
}
