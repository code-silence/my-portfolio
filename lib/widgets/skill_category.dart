import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class SkillCategory extends StatefulWidget {
  final String number;
  final String title;
  final String description;
  final IconData icon;
  final List<String> skills;

  const SkillCategory({
    super.key,
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
    required this.skills,
  });

  @override
  State<SkillCategory> createState() => _SkillCategoryState();
}

class _SkillCategoryState extends State<SkillCategory> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: hovering
                ? AppTheme.neonPurple.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.07),
          ),
          boxShadow: hovering
              ? [
                  BoxShadow(
                    color: AppTheme.neonPurple.withValues(alpha: 0.08),
                    blurRadius: 30,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppTheme.neonPurple.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color:
                          AppTheme.neonPurple.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    widget.icon,
                    color: AppTheme.neonCyan,
                    size: 21,
                  ),
                ),
                const Spacer(),
                Text(
                  widget.number,
                  style: TextStyle(
                    color: AppTheme.neonPurple.withValues(alpha: 0.7),
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              widget.description,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 11,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.skills
                  .map(
                    (skill) => _SkillChip(
                      label: skill,
                      active: hovering,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillChip extends StatelessWidget {
  final String label;
  final bool active;

  const _SkillChip({
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: active
            ? AppTheme.neonPurple.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: 0.035),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: active
              ? AppTheme.neonPurple.withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: active
              ? AppTheme.textPrimary
              : AppTheme.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}