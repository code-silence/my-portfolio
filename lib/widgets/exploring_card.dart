import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class ExploringCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const ExploringCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  State<ExploringCard> createState() => _ExploringCardState();
}

class _ExploringCardState extends State<ExploringCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.neonPurple.withValues(
                alpha: hovering ? 0.12 : 0.07,
              ),
              AppTheme.neonCyan.withValues(
                alpha: hovering ? 0.07 : 0.025,
              ),
            ],
          ),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: hovering
                ? AppTheme.neonCyan.withValues(alpha: 0.35)
                : AppTheme.neonPurple.withValues(alpha: 0.18),
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.neonCyan.withValues(
                  alpha: hovering ? 0.12 : 0.06,
                ),
                border: Border.all(
                  color: AppTheme.neonCyan.withValues(alpha: 0.25),
                ),
              ),
              child: Icon(
                widget.icon,
                color: AppTheme.neonCyan,
                size: 21,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const Text(
                        'LEARNING',
                        style: TextStyle(
                          color: AppTheme.neonCyan,
                          fontSize: 7,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}