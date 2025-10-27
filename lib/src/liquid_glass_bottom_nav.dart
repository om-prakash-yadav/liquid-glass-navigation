import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'liquid_glass_nav_item.dart';

/// Types of haptic feedback available.
enum HapticFeedbackType {
  /// Light impact feedback.
  light,

  /// Medium impact feedback.
  medium,

  /// Heavy impact feedback.
  heavy,

  /// Selection click feedback.
  selection,
}

/// Types of animations for icon transitions.
enum NavAnimationType {
  /// Scale animation.
  scale,

  /// Slide up animation.
  slideUp,

  /// Rotate and scale animation.
  rotateScale,

  /// Fade animation.
  fade,
}

/// A beautiful bottom navigation bar with liquid glass (frosted glass) effect.
///
/// This widget creates an iOS-style navigation bar with a glassmorphism effect
/// that blurs the content behind it. It's highly customizable with options for
/// colors, sizes, gradients, and more.
///
/// Example:
/// ```dart
/// LiquidGlassBottomNav(
///   currentIndex: _currentIndex,
///   onTap: (index) {
///     setState(() {
///       _currentIndex = index;
///     });
///   },
///   items: [
///     LiquidGlassNavItem(
///       icon: Icons.home_rounded,
///       label: 'Home',
///     ),
///     LiquidGlassNavItem(
///       icon: Icons.explore_rounded,
///       label: 'Explore',
///     ),
///   ],
/// )
/// ```
class LiquidGlassBottomNav extends StatefulWidget {
  /// List of navigation items to display.
  final List<LiquidGlassNavItem> items;

  /// The index of the currently selected item.
  final int currentIndex;

  /// Callback function when a navigation item is tapped.
  final Function(int) onTap;

  /// Height of the navigation bar.
  final double height;

  /// Border radius of the navigation bar.
  final double borderRadius;

  /// Margin around the navigation bar.
  final EdgeInsets margin;

  /// Strength of the blur effect (higher = more blur).
  final double blurStrength;

  /// Background color of the navigation bar.
  final Color backgroundColor;

  /// Border color of the navigation bar.
  final Color borderColor;

  /// Width of the border.
  final double borderWidth;

  /// Color of the active (selected) navigation item.
  final Color activeColor;

  /// Color of inactive navigation items.
  final Color inactiveColor;

  /// Whether to show labels below icons.
  final bool showLabels;

  /// Size of the navigation icons.
  final double iconSize;

  /// Font size of the labels.
  final double fontSize;

  /// Font weight of the active item label.
  final FontWeight activeFontWeight;

  /// Font weight of inactive item labels.
  final FontWeight inactiveFontWeight;

  /// Whether to enable shadow effect.
  final bool enableShadow;

  /// Color of the shadow.
  final Color shadowColor;

  /// Blur radius of the shadow.
  final double shadowBlurRadius;

  /// Offset of the shadow.
  final Offset shadowOffset;

  /// Whether to use gradient background instead of solid color.
  final bool useGradient;

  /// Colors for the gradient background (if [useGradient] is true).
  final List<Color>? gradientColors;

  /// Starting point of the gradient.
  final Alignment gradientBegin;

  /// Ending point of the gradient.
  final Alignment gradientEnd;

  /// Duration of the animation when switching between items.
  final Duration animationDuration;

  /// Curve for the animations.
  final Curve animationCurve;

  /// Whether to enable haptic feedback on tap.
  final bool enableHapticFeedback;

  /// Type of haptic feedback.
  final HapticFeedbackType hapticFeedbackType;

  /// Whether to enable ripple effect on tap.
  final bool enableRipple;

  /// Color of the ripple effect.
  final Color? rippleColor;

  /// Type of animation for icon transitions.
  final NavAnimationType animationType;

  /// Whether to enable item bounce animation on tap.
  final bool enableBounceAnimation;

  /// Scale factor for bounce animation.
  final double bounceScale;

  /// Creates a liquid glass bottom navigation bar.
  ///
  /// The [items], [currentIndex], and [onTap] parameters are required.
  const LiquidGlassBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.height = 80,
    this.borderRadius = 30,
    this.margin = const EdgeInsets.all(20),
    this.blurStrength = 20,
    this.backgroundColor = const Color(0x1AFFFFFF),
    this.borderColor = const Color(0x33FFFFFF),
    this.borderWidth = 1.5,
    this.activeColor = Colors.white,
    this.inactiveColor = const Color(0x80FFFFFF),
    this.showLabels = true,
    this.iconSize = 28,
    this.fontSize = 12,
    this.activeFontWeight = FontWeight.w600,
    this.inactiveFontWeight = FontWeight.normal,
    this.enableShadow = true,
    this.shadowColor = const Color(0x1A000000),
    this.shadowBlurRadius = 20,
    this.shadowOffset = const Offset(0, 10),
    this.useGradient = false,
    this.gradientColors,
    this.gradientBegin = Alignment.topLeft,
    this.gradientEnd = Alignment.bottomRight,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOutCubic,
    this.enableHapticFeedback = true,
    this.hapticFeedbackType = HapticFeedbackType.light,
    this.enableRipple = true,
    this.rippleColor,
    this.animationType = NavAnimationType.scale,
    this.enableBounceAnimation = true,
    this.bounceScale = 0.85,
  })  : assert(items.length >= 2, 'Must have at least 2 items'),
        assert(currentIndex >= 0 && currentIndex < items.length,
            'currentIndex must be within items range'),
        assert(bounceScale > 0 && bounceScale <= 1.0,
            'bounceScale must be between 0 and 1.0');

  @override
  State<LiquidGlassBottomNav> createState() => _LiquidGlassBottomNavState();
}

class _LiquidGlassBottomNavState extends State<LiquidGlassBottomNav>
    with TickerProviderStateMixin {
  late List<AnimationController> _bounceControllers;
  late List<Animation<double>> _bounceAnimations;

  @override
  void initState() {
    super.initState();
    _initializeBounceAnimations();
  }

  void _initializeBounceAnimations() {
    _bounceControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 150),
        vsync: this,
      ),
    );

    _bounceAnimations = _bounceControllers
        .map((controller) => Tween<double>(
              begin: 1.0,
              end: widget.bounceScale,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.easeInOut,
            )))
        .toList();
  }

  @override
  void didUpdateWidget(LiquidGlassBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      for (var controller in _bounceControllers) {
        controller.dispose();
      }
      _initializeBounceAnimations();
    }
  }

  @override
  void dispose() {
    for (var controller in _bounceControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleTap(int index) async {
    // Trigger haptic feedback
    if (widget.enableHapticFeedback) {
      switch (widget.hapticFeedbackType) {
        case HapticFeedbackType.light:
          await HapticFeedback.lightImpact();
          break;
        case HapticFeedbackType.medium:
          await HapticFeedback.mediumImpact();
          break;
        case HapticFeedbackType.heavy:
          await HapticFeedback.heavyImpact();
          break;
        case HapticFeedbackType.selection:
          await HapticFeedback.selectionClick();
          break;
      }
    }

    // Trigger bounce animation
    if (widget.enableBounceAnimation) {
      await _bounceControllers[index].forward();
      await _bounceControllers[index].reverse();
    }

    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.margin.left,
      right: widget.margin.right,
      bottom: widget.margin.bottom,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: widget.blurStrength,
            sigmaY: widget.blurStrength,
          ),
          child: Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.useGradient ? null : widget.backgroundColor,
              gradient: widget.useGradient
                  ? LinearGradient(
                      colors: widget.gradientColors ??
                          [
                            widget.backgroundColor,
                            widget.backgroundColor,
                          ],
                      begin: widget.gradientBegin,
                      end: widget.gradientEnd,
                    )
                  : null,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: widget.borderColor,
                width: widget.borderWidth,
              ),
              boxShadow: widget.enableShadow
                  ? [
                      BoxShadow(
                        color: widget.shadowColor,
                        blurRadius: widget.shadowBlurRadius,
                        offset: widget.shadowOffset,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                widget.items.length,
                (index) => _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final item = widget.items[index];
    final isSelected = widget.currentIndex == index;
    final displayIcon =
        isSelected && item.activeIcon != null ? item.activeIcon! : item.icon;

    return Expanded(
      child: ScaleTransition(
        scale: _bounceAnimations[index],
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _handleTap(index),
            splashColor: widget.enableRipple
                ? (widget.rippleColor ?? widget.activeColor.withOpacity(0.2))
                : Colors.transparent,
            highlightColor: widget.enableRipple
                ? (widget.rippleColor ?? widget.activeColor.withOpacity(0.1))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: Semantics(
              label: item.semanticLabel ?? item.label,
              selected: isSelected,
              button: true,
              child: Tooltip(
                message: item.tooltip ?? item.label,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildIconWithBadge(item, displayIcon, isSelected),
                      if (widget.showLabels) ...[
                        const SizedBox(height: 4),
                        _buildAnimatedLabel(item, isSelected),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBadge(
      LiquidGlassNavItem item, IconData icon, bool isSelected) {
    if (!item.showBadge) {
      return _buildAnimatedIcon(icon, isSelected);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        _buildAnimatedIcon(icon, isSelected),
        Positioned(
          right: -4,
          top: -4,
          child: _buildBadge(item),
        ),
      ],
    );
  }

  Widget _buildBadge(LiquidGlassNavItem item) {
    final hasBadgeText = item.badgeText != null && item.badgeText!.isNotEmpty;

    return Container(
      padding: hasBadgeText
          ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
          : const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: item.badgeColor ?? Colors.red,
        borderRadius: BorderRadius.circular(hasBadgeText ? 10 : 5),
        border: Border.all(
          color: Colors.white,
          width: 1.5,
        ),
      ),
      constraints: hasBadgeText
          ? const BoxConstraints(minWidth: 18, minHeight: 18)
          : null,
      child: hasBadgeText
          ? Text(
              item.badgeText!,
              style: TextStyle(
                color: item.badgeTextColor ?? Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            )
          : null,
    );
  }

  Widget _buildAnimatedIcon(IconData icon, bool isSelected) {
    Widget iconWidget = Icon(
      icon,
      key: ValueKey<IconData>(icon),
      color: isSelected ? widget.activeColor : widget.inactiveColor,
      size: widget.iconSize,
    );

    switch (widget.animationType) {
      case NavAnimationType.scale:
        return AnimatedSwitcher(
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: child,
            );
          },
          child: iconWidget,
        );

      case NavAnimationType.slideUp:
        return AnimatedSwitcher(
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: widget.animationCurve,
              )),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: iconWidget,
        );

      case NavAnimationType.rotateScale:
        return AnimatedSwitcher(
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return RotationTransition(
              turns: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          },
          child: iconWidget,
        );

      case NavAnimationType.fade:
        return AnimatedSwitcher(
          duration: widget.animationDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: iconWidget,
        );
    }
  }

  Widget _buildAnimatedLabel(LiquidGlassNavItem item, bool isSelected) {
    return AnimatedDefaultTextStyle(
      duration: widget.animationDuration,
      curve: widget.animationCurve,
      style: TextStyle(
        color: isSelected ? widget.activeColor : widget.inactiveColor,
        fontSize: widget.fontSize,
        fontWeight:
            isSelected ? widget.activeFontWeight : widget.inactiveFontWeight,
      ),
      child: AnimatedOpacity(
        duration: widget.animationDuration,
        opacity: isSelected ? 1.0 : 0.7,
        child: Text(
          item.label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
