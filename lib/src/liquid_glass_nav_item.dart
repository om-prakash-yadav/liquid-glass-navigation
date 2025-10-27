import 'package:flutter/material.dart';

/// Represents a single navigation item in the [LiquidGlassBottomNav].
class LiquidGlassNavItem {
  /// The icon to display for this navigation item.
  final IconData icon;

  /// The label text to display below the icon.
  final String label;

  /// Optional icon to display when this item is active.
  /// If not provided, uses [icon] for both states.
  final IconData? activeIcon;

  /// Optional semantic label for accessibility.
  /// If not provided, uses [label].
  final String? semanticLabel;

  /// Optional tooltip message.
  /// If not provided, uses [label].
  final String? tooltip;

  /// Whether to show a badge on this item.
  final bool showBadge;

  /// Optional text to display in the badge.
  /// If not provided, shows a simple dot.
  final String? badgeText;

  /// Optional color for the badge.
  /// If not provided, uses red color.
  final Color? badgeColor;

  /// Optional text color for the badge.
  final Color? badgeTextColor;

  /// Creates a navigation item.
  ///
  /// The [icon] and [label] parameters are required.
  const LiquidGlassNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
    this.semanticLabel,
    this.tooltip,
    this.showBadge = false,
    this.badgeText,
    this.badgeColor,
    this.badgeTextColor,
  });
}
