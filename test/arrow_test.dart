// TODO

// import 'package:expand_widget/src/expand_arrow.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   Widget makeWidgetTestable(Widget child) =>
//       MaterialApp(home: Scaffold(body: child));

//   testWidgets('Displays nothing', (tester) async {
//     final Animatable<double> _easeInTween = CurveTween(
//       curve: Curves.easeInOutCubic,
//     );
//     final Animatable<double> _halfTween = Tween<double>(
//       begin: 0.0,
//       end: 0.5,
//     );

//     bool pressed = false;

//     await tester.pumpWidget(
//       makeWidgetTestable(ExpandArrow(
//         minMessage: 'minMessage',
//         maxMessage: 'maxMessage',
//         onTap: () => pressed = true,
//         animation: AnimationController(
//           duration: widget.animationDuration,
//           vsync: this,
//         ).drive(_halfTween.chain(_easeInTween)),
//       )),
//     );

//     await tester.tap(find.byIcon(Icons.expand_more));

//     expect(pressed, isTrue);
//     expect(find.byType(SizedBox), findsNothing);
//   });
// }
