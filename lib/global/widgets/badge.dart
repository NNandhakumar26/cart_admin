import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:toyskart_admin/core/constants/colors.dart';

class CustomTabbarBadge extends StatelessWidget {
  final bool showBadge;
  final String? titleText;
  final String badgeText;
  final Color? badgeColor;
  const CustomTabbarBadge({
    required this.showBadge,
    required this.titleText,
    required this.badgeText,
    this.badgeColor = ColorConst.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeStyle: badges.BadgeStyle(
        padding: const EdgeInsets.all(8.0),
        badgeColor: badgeColor ?? Colors.red,
      ),
      showBadge: showBadge,
      badgeContent: Text(
        badgeText,
        style: const TextStyle(
          color: ColorConst.background,
          fontSize: 12,
        ),
      ),
      badgeAnimation: const badges.BadgeAnimation.fade(),
      position: badges.BadgePosition.topEnd(
        top: -22,
      ),
      child: Visibility(
        visible: titleText != null,
        child: Text(
          titleText!,
          style: const TextStyle(
            fontSize: 12,
            color: ColorConst.white,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class CustomBadge extends StatelessWidget {
  final String title;
  final IconData iconData;
  const CustomBadge({required this.title, required this.iconData, super.key});

  @override
  Widget build(BuildContext context) {
    return badges.Badge(
      badgeContent: Text(
        title,
        style: const TextStyle(
            color: ColorConst.primary,
            fontSize: 10,
            fontWeight: FontWeight.bold),
      ),
      badgeStyle: const badges.BadgeStyle(
        padding: EdgeInsets.all(6),
        badgeColor: ColorConst.white,
      ),
      child: Icon(iconData, color: ColorConst.white),
    );
  }
}
