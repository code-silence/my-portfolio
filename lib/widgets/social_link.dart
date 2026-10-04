import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/theme/app_theme.dart';

class SocialLink extends StatefulWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const SocialLink({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<SocialLink> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: hovering
                ? AppTheme.neonPurple.withValues(alpha: 0.15)
                : Colors.white.withValues(alpha: 0.025),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hovering
                  ? AppTheme.neonCyan.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.08),
            ),
            boxShadow: hovering
                ? [
                    BoxShadow(
                      color: AppTheme.neonPurple.withValues(alpha: 0.15),
                      blurRadius: 22,
                    ),
                  ]
                : null,
          ),
          child: FaIcon(
            widget.icon,
            size: 20,
            color: hovering
                ? AppTheme.neonCyan
                : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }
}