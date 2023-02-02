import 'package:flutter/widgets.dart';

/// This function is used to override the `ExpandArrow` widget for controlling
/// a `ExpandChild` or `ExpandText` widget.
typedef IndicatorBuilder = Widget Function(
  BuildContext context,
  VoidCallback onTap,
  bool isExpanded,
);
