import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/theme/app_theme.dart';
import '../models/project.dart';
import 'project_visual.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool hovering = false;

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: hovering ? 0.92 : 0.72),
          borderRadius: BorderRadius.circular(21),
          border: Border.all(
            color: hovering
                ? AppTheme.neonPurple.withValues(alpha: 0.42)
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
            ProjectVisual(project: project),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: _buildContent(project),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(Project project) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.name,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          project.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 11,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies
              .map(
                (technology) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.neonPurple.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: AppTheme.neonPurple.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Text(
                    technology,
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
                const SizedBox(height: 16),

        // Project action / private status
        if (project.githubUrl != null)
          _ProjectAction(
            icon: Icons.code_rounded,
            label: 'VIEW ON GITHUB',
            enabled: true,
            onTap: () => _openUrl(project.githubUrl!),
          )
        else
          const _PrivateProjectBadge(),
      ],
    );
  }
}

class _PrivateProjectBadge extends StatelessWidget {
  const _PrivateProjectBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.025),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 15,
            color: AppTheme.textSecondary.withValues(alpha: 0.65),
          ),
          const SizedBox(width: 8),
          Text(
            'THIS IS A PRIVATE PROJECT',
            style: TextStyle(
              color: AppTheme.textSecondary.withValues(alpha: 0.65),
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool enabled;
  final VoidCallback onTap;

  const _ProjectAction({
    required this.icon,
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  @override
  State<_ProjectAction> createState() => _ProjectActionState();
}

class _ProjectActionState extends State<_ProjectAction> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          hovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          hovering = false;
        });
      },
      child: InkWell(
        onTap: widget.enabled ? widget.onTap : null,
        borderRadius: BorderRadius.circular(11),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            color: hovering
                ? AppTheme.neonPurple.withValues(alpha: 0.18)
                : AppTheme.neonPurple.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: hovering
                  ? AppTheme.neonCyan.withValues(alpha: 0.42)
                  : AppTheme.neonPurple.withValues(alpha: 0.22),
            ),
            boxShadow: hovering
                ? [
                    BoxShadow(
                      color: AppTheme.neonPurple.withValues(alpha: 0.16),
                      blurRadius: 20,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 17,
                color: hovering ? AppTheme.neonCyan : AppTheme.textPrimary,
              ),
              const SizedBox(width: 9),
              Text(
                widget.label,
                style: TextStyle(
                  color: hovering ? AppTheme.neonCyan : AppTheme.textPrimary,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_outward_rounded,
                size: 14,
                color: hovering ? AppTheme.neonCyan : AppTheme.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
