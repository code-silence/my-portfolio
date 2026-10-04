import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/project.dart';

class ProjectFilter extends StatelessWidget {
  final ProjectCategory selected;
  final ValueChanged<ProjectCategory> onChanged;

  const ProjectFilter({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const filters = [
      (ProjectCategory.all, 'ALL'),
      (ProjectCategory.app, 'APPS'),
      (ProjectCategory.website, 'WEBSITES'),
      (ProjectCategory.automation, 'AUTOMATION'),
    ];

    return Wrap(
      spacing: 7,
      runSpacing: 7,
      children: [
        for (final filter in filters)
          _FilterButton(
            label: filter.$2,
            selected: selected == filter.$1,
            onTap: () => onChanged(filter.$1),
          ),
      ],
    );
  }
}

class _FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.neonPurple.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.025),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected
                ? AppTheme.neonPurple.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected
                ? AppTheme.neonCyan
                : AppTheme.textSecondary,
            fontSize: 8,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}