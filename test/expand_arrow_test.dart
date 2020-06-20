import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expand_widget/expand_widget.dart';

const String tooltipText = 'TIP';

const Duration kExpand = Duration(milliseconds: 300);

class TestPage extends StatelessWidget {
  final Widget test;

  const TestPage(this.test);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text('AppBar'),
          ),
          body: test,
        ),
      ),
    );
  }
}

void main() {
  group('Test hint strings', () {
    testWidgets('Correct pull of default collapse hint text', (tester) async {
      final AnimationController controller = AnimationController(
        duration: kExpand,
        vsync: const TestVSync(),
      );
      final halfTurn = Tween<double>(begin: 0.0, end: 0.5);
      final easeInCurve = CurveTween(curve: Curves.easeInOutCubic);
      final turnAnimation = controller.drive(halfTurn.chain(easeInCurve));

      await tester.pumpWidget(TestPage(
        ExpandArrow(
          animation: turnAnimation,
        ),
      ));

      await tester.tap(find.byIcon(Icons.expand_more));
      expect(
        find.byTooltip(DefaultMaterialLocalizations().collapsedIconTapHint),
        findsOneWidget,
      );
    });

    testWidgets('Correct pull of custom collapse hint text', (tester) async {
      final AnimationController controller = AnimationController(
        duration: kExpand,
        vsync: const TestVSync(),
      );
      final halfTurn = Tween<double>(begin: 0.0, end: 0.5);
      final easeInCurve = CurveTween(curve: Curves.easeInOutCubic);
      final turnAnimation = controller.drive(halfTurn.chain(easeInCurve));

      await tester.pumpWidget(TestPage(
        ExpandArrow(
          collapsedHint: tooltipText,
          animation: turnAnimation,
        ),
      ));

      await tester.tap(find.byIcon(Icons.expand_more));
      expect(find.byTooltip(tooltipText), findsOneWidget);
    });

    testWidgets('Correct pull of default expanded hint text', (tester) async {
      final AnimationController controller = AnimationController(
        duration: kExpand,
        vsync: const TestVSync(),
      );
      final halfTurn = Tween<double>(begin: 0.0, end: 0.5);
      final easeInCurve = CurveTween(curve: Curves.easeInOutCubic);
      final turnAnimation = controller.drive(halfTurn.chain(easeInCurve));

      await tester.pumpWidget(TestPage(
        ExpandArrow(
          animation: turnAnimation,
          onTap: () => controller.forward(),
        ),
      ));

      await tester.tap(find.byIcon(Icons.expand_more));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
      expect(
        find.byTooltip(DefaultMaterialLocalizations().expandedIconTapHint),
        findsOneWidget,
      );
    });

    // testWidgets('Correct pull of custom expanded hint text', (tester) async {
    //   final AnimationController controller = AnimationController(
    //     duration: kExpand,
    //     vsync: const TestVSync(),
    //   );
    //   final halfTurn = Tween<double>(begin: 0.0, end: 0.5);
    //   final easeInCurve = CurveTween(curve: Curves.easeInOutCubic);
    //   final turnAnimation = controller.drive(halfTurn.chain(easeInCurve));

    //   await tester.pumpWidget(TestPage(
    //     ExpandArrow(
    //       animation: turnAnimation,
    //       onTap: () => controller.forward(),
    //       expandedHint: tooltipText,
    //     ),
    //   ));

    //   await tester.tap(find.byIcon(Icons.expand_more));
    //   await tester.pump(kExpand);
    //   expect(find.byTooltip(tooltipText), findsOneWidget);
    // });
  });

  group('Test various widget decoration features', () {});

  group('Test widget tap', () {});

  group('Test animation property', () {});

  group('Test different render modes', () {});
}
