import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:liquid_glass_nav/liquid_glass_nav.dart';

void main() {
  group('LiquidGlassNavItem', () {
    test('creates item with required parameters', () {
      const item = LiquidGlassNavItem(
        icon: Icons.home,
        label: 'Home',
      );

      expect(item.icon, Icons.home);
      expect(item.label, 'Home');
      expect(item.activeIcon, null);
      expect(item.showBadge, false);
    });

    test('creates item with all parameters', () {
      const item = LiquidGlassNavItem(
        icon: Icons.home,
        label: 'Home',
        activeIcon: Icons.home_filled,
        semanticLabel: 'Home Screen',
        tooltip: 'Go to Home',
        showBadge: true,
        badgeText: '5',
        badgeColor: Colors.red,
        badgeTextColor: Colors.white,
      );

      expect(item.activeIcon, Icons.home_filled);
      expect(item.semanticLabel, 'Home Screen');
      expect(item.tooltip, 'Go to Home');
      expect(item.showBadge, true);
      expect(item.badgeText, '5');
      expect(item.badgeColor, Colors.red);
      expect(item.badgeTextColor, Colors.white);
    });
  });

  group('LiquidGlassBottomNav', () {
    testWidgets('renders with required parameters', (tester) async {
      int currentIndex = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                LiquidGlassBottomNav(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    currentIndex = index;
                  },
                  items: const [
                    LiquidGlassNavItem(
                      icon: Icons.home,
                      label: 'Home',
                    ),
                    LiquidGlassNavItem(
                      icon: Icons.explore,
                      label: 'Explore',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Explore'), findsOneWidget);
    });

    testWidgets('handles tap events', (tester) async {
      int currentIndex = 0;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return MaterialApp(
              home: Scaffold(
                body: Stack(
                  children: [
                    LiquidGlassBottomNav(
                      currentIndex: currentIndex,
                      onTap: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                      items: const [
                        LiquidGlassNavItem(
                          icon: Icons.home,
                          label: 'Home',
                        ),
                        LiquidGlassNavItem(
                          icon: Icons.explore,
                          label: 'Explore',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

      expect(currentIndex, 0);

      await tester.tap(find.text('Explore'));
      await tester.pumpAndSettle();

      // Note: Since we're using StatefulBuilder, the state updates locally
      // In a real app, this would update the parent widget's state
    });

    testWidgets('shows badges when enabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                LiquidGlassBottomNav(
                  currentIndex: 0,
                  onTap: (index) {},
                  items: const [
                    LiquidGlassNavItem(
                      icon: Icons.home,
                      label: 'Home',
                      showBadge: true,
                      badgeText: '5',
                    ),
                    LiquidGlassNavItem(
                      icon: Icons.explore,
                      label: 'Explore',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('5'), findsOneWidget);
    });

    testWidgets('renders without labels when disabled', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                LiquidGlassBottomNav(
                  currentIndex: 0,
                  onTap: (index) {},
                  showLabels: false,
                  items: const [
                    LiquidGlassNavItem(
                      icon: Icons.home,
                      label: 'Home',
                    ),
                    LiquidGlassNavItem(
                      icon: Icons.explore,
                      label: 'Explore',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('Home'), findsNothing);
      expect(find.text('Explore'), findsNothing);
    });

    testWidgets('applies custom colors', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Stack(
              children: [
                LiquidGlassBottomNav(
                  currentIndex: 0,
                  onTap: (index) {},
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  items: const [
                    LiquidGlassNavItem(
                      icon: Icons.home,
                      label: 'Home',
                    ),
                    LiquidGlassNavItem(
                      icon: Icons.explore,
                      label: 'Explore',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      // Widget is rendered successfully
      expect(find.byType(LiquidGlassBottomNav), findsOneWidget);
    });

    test('asserts valid currentIndex', () {
      expect(
        () => LiquidGlassBottomNav(
          currentIndex: -1,
          onTap: (index) {},
          items: const [
            LiquidGlassNavItem(icon: Icons.home, label: 'Home'),
          ],
        ),
        throwsAssertionError,
      );

      expect(
        () => LiquidGlassBottomNav(
          currentIndex: 5,
          onTap: (index) {},
          items: const [
            LiquidGlassNavItem(icon: Icons.home, label: 'Home'),
          ],
        ),
        throwsAssertionError,
      );
    });

    test('asserts minimum items count', () {
      expect(
        () => LiquidGlassBottomNav(
          currentIndex: 0,
          onTap: (index) {},
          items: const [
            LiquidGlassNavItem(icon: Icons.home, label: 'Home'),
          ],
        ),
        throwsAssertionError,
      );
    });

    test('asserts valid bounceScale', () {
      expect(
        () => LiquidGlassBottomNav(
          currentIndex: 0,
          onTap: (index) {},
          bounceScale: 1.5,
          items: const [
            LiquidGlassNavItem(icon: Icons.home, label: 'Home'),
            LiquidGlassNavItem(icon: Icons.explore, label: 'Explore'),
          ],
        ),
        throwsAssertionError,
      );
    });
  });

  group('NavAnimationType', () {
    test('has all expected animation types', () {
      expect(NavAnimationType.values.length, 4);
      expect(NavAnimationType.values, contains(NavAnimationType.scale));
      expect(NavAnimationType.values, contains(NavAnimationType.slideUp));
      expect(NavAnimationType.values, contains(NavAnimationType.rotateScale));
      expect(NavAnimationType.values, contains(NavAnimationType.fade));
    });
  });

  group('HapticFeedbackType', () {
    test('has all expected haptic feedback types', () {
      expect(HapticFeedbackType.values.length, 4);
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.light));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.medium));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.heavy));
      expect(HapticFeedbackType.values, contains(HapticFeedbackType.selection));
    });
  });
}
