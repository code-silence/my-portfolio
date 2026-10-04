import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../models/project.dart';
import 'project_visual.dart';

class FeaturedProject extends StatefulWidget {
  final Project project;

  const FeaturedProject({
    super.key,
    required this.project,
  });

  @override
  State<FeaturedProject> createState() => _FeaturedProjectState();
}

class _FeaturedProjectState extends State<FeaturedProject> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(
            alpha: hovering ? 0.94 : 0.78,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: hovering
                ? AppTheme.neonCyan.withValues(alpha: 0.4)
                : AppTheme.neonPurple.withValues(alpha: 0.15),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonPurple.withValues(
                alpha: hovering ? 0.11 : 0.045,
              ),
              blurRadius: 40,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 700;

            if (mobile) {
              return Column(
                children: [
                  ProjectVisual(
                    project: project,
                    large: true,
                  ),
                  const SizedBox(height: 22),
                  _buildDetails(project),
                ],
              );
            }

            return Row(
              children: [
                Expanded(
                  flex: 6,
                  child: ProjectVisual(
                    project: project,
                    large: true,
                  ),
                ),
                const SizedBox(width: 28),
                Expanded(
                  flex: 5,
                  child: _buildDetails(project),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetails(Project project) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FEATURED PROJECT',
            style: TextStyle(
              color: AppTheme.neonCyan,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.5,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            project.name,
            style: const TextStyle(
              fontSize: 30,
              height: 1.1,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.7,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            project.description,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 13,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 22),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: project.technologies
                .map(
                  (tech) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.neonPurple.withValues(alpha: 0.09),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            AppTheme.neonPurple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 26),
          Row(
            children: [
              _FeaturedAction(
                label: 'GITHUB',
                icon: Icons.code_rounded,
                enabled: project.githubUrl != null,
                onTap: () {},
              ),
              const SizedBox(width: 10),
              _FeaturedAction(
                label: 'VIEW PROJECT',
                icon: Icons.arrow_outward_rounded,
                enabled: project.liveUrl != null,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeaturedAction extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  const _FeaturedAction({
    required this.label,
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: enabled
              ? AppTheme.neonPurple.withValues(alpha: 0.12)
              : Colors.white.withValues(alpha: 0.025),
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: enabled
                ? AppTheme.neonPurple.withValues(alpha: 0.28)
                : Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14,
              color: enabled
                  ? AppTheme.neonCyan
                  : AppTheme.textSecondary.withValues(alpha: 0.3),
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                color: enabled
                    ? AppTheme.textPrimary
                    : AppTheme.textSecondary.withValues(alpha: 0.3),
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}