import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class InternshipCard extends StatefulWidget {
  final VoidCallback? onContact;

  const InternshipCard({
    super.key,
    this.onContact,
  });

  @override
  State<InternshipCard> createState() => _InternshipCardState();
}

class _InternshipCardState extends State<InternshipCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.neonPurple.withValues(
                alpha: hovering ? 0.13 : 0.08,
              ),
              AppTheme.neonCyan.withValues(
                alpha: hovering ? 0.07 : 0.025,
              ),
              AppTheme.surface.withValues(alpha: 0.75),
            ],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: hovering
                ? AppTheme.neonCyan.withValues(alpha: 0.4)
                : AppTheme.neonPurple.withValues(alpha: 0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.neonPurple.withValues(
                alpha: hovering ? 0.1 : 0.04,
              ),
              blurRadius: 35,
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 600;

            if (mobile) {
              return _buildMobile();
            }

            return _buildDesktop();
          },
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        Expanded(
          child: _buildContent(),
        ),
        const SizedBox(width: 30),
        _buildButton(),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContent(),
        const SizedBox(height: 22),
        _buildButton(),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.neonCyan,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.neonCyan,
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'CURRENTLY LOOKING FOR',
              style: TextStyle(
                color: AppTheme.neonCyan,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 17),
        const Text(
          'SOFTWARE / MOBILE APP\nDEVELOPMENT INTERNSHIP',
          style: TextStyle(
            fontSize: 22,
            height: 1.2,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 13),
        const Text(
          'Looking for an opportunity to learn from a real '
          'development environment, contribute to meaningful '
          'projects, and grow as a developer.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            height: 1.65,
          ),
        ),
      ],
    );
  }

  Widget _buildButton() {
    return InkWell(
      onTap: widget.onContact,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppTheme.neonPurple.withValues(alpha: 0.13),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppTheme.neonPurple.withValues(alpha: 0.35),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'GET IN TOUCH',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons.arrow_outward_rounded,
              size: 14,
              color: AppTheme.neonCyan,
            ),
          ],
        ),
      ),
    );
  }
}