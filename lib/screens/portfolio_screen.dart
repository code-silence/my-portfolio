import 'package:flutter/material.dart';

import '../core/constants/app_constants.dart';
import '../core/theme/app_theme.dart';
import '../widgets/mobile_drawer.dart';
import '../widgets/neon_background.dart';
import '../widgets/profile_visual.dart';
import '../widgets/side_panel.dart';
import '../widgets/about_visual.dart';
import '../widgets/info_card.dart';
import '../widgets/exploring_card.dart';
import '../widgets/skill_category.dart';
import '../data/projects.dart';
import '../models/project.dart';
import '../widgets/featured_project.dart';
import '../widgets/project_card.dart';
import '../widgets/project_filter.dart';
import '../widgets/internship_card.dart';
import '../widgets/journey_item.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/contact_card.dart';
import '../widgets/social_link.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  int selectedIndex = 0;
  bool mobileDrawerOpen = false;

  ProjectCategory _selectedProjectCategory = ProjectCategory.all;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();

    super.dispose();
  }

  Widget _buildDesktopAbout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(flex: 5, child: AboutVisual()),
        const SizedBox(width: 25),
        Expanded(flex: 7, child: _buildAboutDetails(context)),
      ],
    );
  }

  Widget _buildMobileAbout(BuildContext context) {
    return Column(
      children: [
        const AboutVisual(),
        const SizedBox(height: 24),
        _buildAboutDetails(context),
      ],
    );
  }

  Widget _buildAboutDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'WHO I AM',
          style: TextStyle(
            color: AppTheme.neonCyan,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 3,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'A graduated CSE student with a passion for building software.',
          style: TextStyle(
            fontSize: 24,
            height: 1.25,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'I am a graduated Computer Science & Engineering student at '
          'Daffodil International University and an aspiring '
          'mobile app developer. I enjoy creating applications, '
          'experimenting with technologies and learning through '
          'hands-on projects.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 14,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 30),
        LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 500;

            final cards = [
              const InfoCard(
                label: 'Degree',
                value: 'BSc in CSE',
                icon: Icons.school_rounded,
              ),
              const InfoCard(
                label: 'University',
                value: 'Daffodil International University',
                icon: Icons.account_balance_rounded,
              ),
              const InfoCard(
                label: 'Location',
                value: AppConstants.location,
                icon: Icons.location_on_rounded,
              ),
              const InfoCard(
                label: 'Focus',
                value: 'Mobile App Development',
                icon: Icons.phone_android_rounded,
              ),
            ];

            if (narrow) {
              return Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    const SizedBox(height: 12),
                  ],
                ],
              );
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cards.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                mainAxisExtent: 92,
              ),
              itemBuilder: (_, index) => cards[index],
            );
          },
        ),
        const SizedBox(height: 25),
        _buildAboutStats(),
      ],
    );
  }

  Widget _buildAboutStats() {
    return Row(
      children: const [
        _AboutStat(number: '01', label: 'CSE STUDENT'),
        SizedBox(width: 12),
        _AboutStat(number: '∞', label: 'THINGS TO LEARN'),
        SizedBox(width: 12),
        _AboutStat(number: '24/7', label: 'CURIOUS'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeonBackground(
        child: Stack(
          children: [
            Row(
              children: [
                if (_isDesktop(context))
                  SidePanel(
                    selectedIndex: selectedIndex,
                    onItemSelected: _scrollToSection,
                  )
                else if (_isTablet(context))
                  SidePanel(
                    selectedIndex: selectedIndex,
                    compact: true,
                    onItemSelected: _scrollToSection,
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (_isMobile(context)) _buildMobileTopBar(),
                      Expanded(child: _buildScrollableContent(context)),
                    ],
                  ),
                ),
              ],
            ),
            if (mobileDrawerOpen && _isMobile(context))
              _buildMobileDrawerOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableContent(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.symmetric(
        horizontal: _isDesktop(context)
            ? 70
            : _isTablet(context)
            ? 45
            : 24,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1150),
          child: Column(
            children: [
              _buildHomeSection(context),
              _buildAboutSection(context),
              _buildSkillsSection(context),
              _buildProjectsSection(context),
              _buildJourneySection(context),
              _buildContactSection(context),
              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // HOME
  // ------------------------------------------------------------

  Widget _buildHomeSection(BuildContext context) {
    return Container(
      key: _sectionKeys[0],
      constraints: BoxConstraints(minHeight: MediaQuery.sizeOf(context).height),
      alignment: Alignment.center,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 800;

          if (mobile) {
            return _buildMobileHero(context);
          }

          return _buildDesktopHero(context);
        },
      ),
    );
  }

  Widget _buildDesktopHero(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 11, child: _buildHeroContent(context)),
        const SizedBox(width: 55),
        const Expanded(flex: 7, child: Center(child: ProfileVisual())),
      ],
    );
  }

  Widget _buildMobileHero(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroContent(context),
        const SizedBox(height: 55),
        const Center(child: ProfileVisual()),
      ],
    );
  }

  Widget _buildHeroContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatusIndicator(),
        const SizedBox(height: 24),
        const Text(
          'HELLO, I AM',
          style: TextStyle(
            color: AppTheme.neonCyan,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 15),
        _responsiveName(context),
        const SizedBox(height: 18),
        _buildRoleText(context),
        const SizedBox(height: 22),
        SizedBox(
          width: 650,
          child: Text(
            AppConstants.shortIntro,
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: _isMobile(context) ? 15 : 17,
              height: 1.75,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            _ActionButton(
              label: 'VIEW PROJECTS',
              filled: true,
              onTap: () => _scrollToSection(3),
            ),
            _ActionButton(
              label: 'CONTACT ME',
              filled: false,
              onTap: () => _scrollToSection(5),
            ),
          ],
        ),
        const SizedBox(height: 30),
        _buildTechLine(),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF48FF91),
            boxShadow: [BoxShadow(color: Color(0xFF48FF91), blurRadius: 10)],
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          'AVAILABLE TO BUILD',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleText(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: _isMobile(context) ? 20 : 25,
          fontWeight: FontWeight.w700,
        ),
        children: const [
          TextSpan(
            text: 'SOFTWARE EINGINEER ',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
          TextSpan(
            text: '& MOBILE APP DEVELOPER',
            style: TextStyle(color: AppTheme.neonPurple),
          ),
        ],
      ),
    );
  }

  Widget _buildTechLine() {
    const technologies = ['FLUTTER', 'DART', 'C++', 'PYTHON', 'REACT NATIVE', 'JAVASCRIPT', 'HTML', 'CSS', 'FIREBASE', 'SUPABASE', 'GIT', 'GITHUB', 'PLAYWRIGHT'];

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: [
        for (int i = 0; i < technologies.length; i++) ...[
          Text(
            technologies[i],
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          if (i != technologies.length - 1)
            const Text(
              '•',
              style: TextStyle(color: AppTheme.neonCyan, fontSize: 10),
            ),
        ],
      ],
    );
  }

  Widget _responsiveName(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    double fontSize;

    if (width < 500) {
      fontSize = 48;
    } else if (width < 900) {
      fontSize = 62;
    } else {
      fontSize = 76;
    }

    return Text(
      AppConstants.name,
      style: TextStyle(
        fontSize: fontSize,
        height: 0.95,
        fontWeight: FontWeight.w900,
        letterSpacing: -3,
      ),
    );
  }

  // ------------------------------------------------------------
  // ABOUT
  // ------------------------------------------------------------

  Widget _buildAboutSection(BuildContext context) {
    return _SectionContainer(
      key: _sectionKeys[1],
      title: 'ABOUT ME',
      subtitle: 'More than just writing code.',
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 800;

          if (mobile) {
            return _buildMobileAbout(context);
          }

          return _buildDesktopAbout(context);
        },
      ),
    );
  }

  

  // ------------------------------------------------------------
  // SKILLS
  // ------------------------------------------------------------

  Widget _buildSkillsSection(BuildContext context) {
    return _SectionContainer(
      key: _sectionKeys[2],
      title: 'SKILLS',
      subtitle: 'Tools I build with.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSkillCategories(context),
          const SizedBox(height: 45),
          _buildExploringSection(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // PROJECTS
  // ------------------------------------------------------------

  Widget _buildProjectsSection(BuildContext context) {
    return _SectionContainer(
      key: _sectionKeys[3],
      title: 'PROJECTS',
      subtitle: 'Things I have built, explored and experimented with.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFeaturedProjects(context),
          const SizedBox(height: 42),
          _buildProjectLibrary(context),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // RESUME
  // ------------------------------------------------------------

  Widget _buildJourneySection(BuildContext context) {
    return _SectionContainer(
      key: _sectionKeys[4],
      title: 'JOURNEY',
      subtitle: 'Where I am and where I am heading.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJourneyTimeline(),
          const SizedBox(height: 20),
          const InternshipCard(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // CONTACT
  // ------------------------------------------------------------

  Widget _buildContactSection(BuildContext context) {
    return _SectionContainer(
      key: _sectionKeys[5],
      title: 'CONTACT',
      subtitle: 'Have an opportunity or something interesting to build?',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildContactHero(),
          const SizedBox(height: 18),
          _buildContactDetails(context),
          const SizedBox(height: 25),
          _buildSocialLinks(),
          const SizedBox(height: 30),
          _buildFooter(),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // MOBILE NAVIGATION
  // ------------------------------------------------------------

  Widget _buildMobileTopBar() {
    return SafeArea(
      bottom: false,
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.88),
          border: Border(
            bottom: BorderSide(color: Colors.white.withValues(alpha: 0.07)),
          ),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  mobileDrawerOpen = true;
                });
              },
              icon: const Icon(Icons.menu_rounded),
              color: AppTheme.neonCyan,
            ),
            const SizedBox(width: 8),
            const Text(
              AppConstants.name,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const Spacer(),
            Text(
              _sectionName(selectedIndex),
              style: const TextStyle(
                color: AppTheme.neonPurple,
                fontSize: 10,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileDrawerOverlay() {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !mobileDrawerOpen,
        child: Stack(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              opacity: mobileDrawerOpen ? 1.0 : 0.0,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mobileDrawerOpen = false;
                  });
                },
                child: Container(color: Colors.black.withValues(alpha: 0.68)),
              ),
            ),

            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOutCubic,
              left: mobileDrawerOpen ? 0 : -290,
              top: 0,
              bottom: 0,
              child: MobileDrawer(
                selectedIndex: selectedIndex,
                onItemSelected: _scrollToSection,
                onClose: () {
                  setState(() {
                    mobileDrawerOpen = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // SCROLLING
  // ------------------------------------------------------------

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;

    if (context == null) {
      return;
    }

    setState(() {
      selectedIndex = index;
      mobileDrawerOpen = false;
    });

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      alignment: 0.04,
    );
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) {
      return;
    }

    int closestIndex = selectedIndex;
    double closestDistance = double.infinity;

    for (int i = 0; i < _sectionKeys.length; i++) {
      final context = _sectionKeys[i].currentContext;

      if (context == null) {
        continue;
      }

      final renderObject = context.findRenderObject();

      if (renderObject is! RenderBox) {
        continue;
      }

      final position = renderObject.localToGlobal(Offset.zero).dy;
      final distance = position.abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestIndex = i;
      }
    }

    if (closestIndex != selectedIndex) {
      setState(() {
        selectedIndex = closestIndex;
      });
    }
  }

  String _sectionName(int index) {
    const names = ['HOME', 'ABOUT', 'SKILLS', 'PROJECTS', 'JOURNEY', 'CONTACT'];

    return names[index];
  }

  bool _isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1100;
  }

  bool _isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 700 && width < 1100;
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 700;
  }

  Widget _buildSkillCategories(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900 ? 2 : 1;

        final categories = const [
          SkillCategory(
            number: '01',
            title: 'PROGRAMMING',
            description:
                'Languages I use for problem solving and software development.',
            icon: Icons.terminal_rounded,
            skills: ['C++', 'Python', 'Dart', 'JavaScript'],
          ),
          SkillCategory(
            number: '02',
            title: 'MOBILE DEVELOPMENT',
            description: 'Building cross-platform applications and exploring modern mobile technologies.',
            icon: Icons.phone_android_rounded,
            skills: ['Flutter', 'React Native', 'Firebase', 'Supabase'],
          ),
          SkillCategory(
            number: '03',
            title: 'WEB DEVELOPMENT',
            description: 'Creating responsive interfaces and web experiences.',
            icon: Icons.language_rounded,
            skills: ['HTML', 'CSS', 'JavaScript', 'Flutter Web'],
          ),
          SkillCategory(
            number: '04',
            title: 'TOOLS & AUTOMATION',
            description:
                'Developer tools and automation technologies I work with.',
            icon: Icons.build_rounded,
            skills: ['Git', 'GitHub', 'VS Code', 'Playwright', 'Python'],
          ),
        ];

        if (columns == 1) {
          return Column(
            children: [
              for (final category in categories) ...[
                category,
                const SizedBox(height: 16),
              ],
            ],
          );
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            mainAxisExtent: 275,
          ),
          itemBuilder: (_, index) => categories[index],
        );
      },
    );
  }

  Widget _buildExploringSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.neonCyan,
                boxShadow: [
                  BoxShadow(color: AppTheme.neonCyan, blurRadius: 10),
                ],
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'CURRENTLY EXPLORING',
              style: TextStyle(
                color: AppTheme.neonCyan,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final stacked = constraints.maxWidth < 700;

            final cards = const [
              ExploringCard(
                title: 'React Native',
                description: 'Exploring cross-platform mobile development.',
                icon: Icons.phone_android_rounded,
              ),
              ExploringCard(
                title: 'Web Automation',
                description: 'Building browser automation workflows with Python and Playwright.',
                icon: Icons.smart_toy_rounded,
              ),
            ];

            if (stacked) {
              return Column(
                children: [
                  for (final card in cards) ...[
                    card,
                    const SizedBox(height: 12),
                  ],
                ],
              );
            }

            return Row(
              children: [
                Expanded(child: cards[0]),
                const SizedBox(width: 14),
                Expanded(child: cards[1]),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeaturedProjects(BuildContext context) {
    final featured = portfolioProjects
        .where((project) => project.featured)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'SELECTED WORK',
          style: TextStyle(
            color: AppTheme.neonCyan,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.5,
          ),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 750) {
              return Column(
                children: [
                  for (final project in featured) ...[
                    FeaturedProject(project: project),
                    const SizedBox(height: 16),
                  ],
                ],
              );
            }

            return Column(
              children: [
                FeaturedProject(project: featured[0]),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: FeaturedProject(project: featured[1])),
                    const SizedBox(width: 16),
                    Expanded(child: FeaturedProject(project: featured[2])),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildProjectLibrary(BuildContext context) {
    final projects = _selectedProjectCategory == ProjectCategory.all
        ? portfolioProjects
        : portfolioProjects
              .where((project) => project.category == _selectedProjectCategory)
              .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final mobile = constraints.maxWidth < 650;

            if (mobile) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PROJECT LIBRARY',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Browse more of my work.',
                    style: TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProjectFilter(
                    selected: _selectedProjectCategory,
                    onChanged: (category) {
                      setState(() {
                        _selectedProjectCategory = category;
                      });
                    },
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PROJECT LIBRARY',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Browse more of my work.',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                ProjectFilter(
                  selected: _selectedProjectCategory,
                  onChanged: (category) {
                    setState(() {
                      _selectedProjectCategory = category;
                    });
                  },
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 1050
                ? 3
                : constraints.maxWidth >= 650
                ? 2
                : 1;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                mainAxisExtent: 420,
              ),
              itemBuilder: (_, index) {
                return ProjectCard(project: projects[index]);
              },
            );
          },
        ),
        const SizedBox(height: 28),
        _buildRepositoryLink(),
      ],
    );
  }

  Widget _buildRepositoryLink() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppTheme.neonPurple.withValues(alpha: 0.15),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.code_rounded, color: AppTheme.neonCyan, size: 17),
            SizedBox(width: 10),
            Text(
              'WANT TO CHECK MY REPOSITORIES?',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_outward_rounded,
              color: AppTheme.neonPurple,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJourneyTimeline() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 5),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: const Column(
        children: [
          JourneyItem(
            year: '2023 — NOW',
            title: 'BSc in Computer Science & Engineering',
            subtitle: 'DAFFODIL INTERNATIONAL UNIVERSITY',
            description:
                'Currently pursuing my Bachelor of Science in '
                'Computer Science & Engineering while building '
                'personal and academic software projects.',
            icon: Icons.school_rounded,
          ),
          JourneyItem(
            year: '2021',
            title: 'Higher Secondary Certificate',
            subtitle: 'GOVT. PC COLLEGE',
            description:
                'Completed HSC in Science with a strong foundation '
                'in mathematics, science and problem solving.',
            icon: Icons.menu_book_rounded,
            last: true,
          ),
        ],
      ),
    );
  }

  Widget _buildContactHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.neonPurple.withValues(alpha: 0.12),
            AppTheme.neonCyan.withValues(alpha: 0.04),
            AppTheme.surface.withValues(alpha: 0.75),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.neonPurple.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppTheme.neonPurple.withValues(alpha: 0.06),
            blurRadius: 40,
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mobile = constraints.maxWidth < 650;

          if (mobile) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactHeroText(),
                const SizedBox(height: 22),
                _buildEmailButton(),
              ],
            );
          }

          return Row(
            children: [
              Expanded(child: _buildContactHeroText()),
              const SizedBox(width: 25),
              _buildEmailButton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContactHeroText() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 8, color: AppTheme.neonCyan),
            SizedBox(width: 9),
            Text(
              'OPEN TO OPPORTUNITIES',
              style: TextStyle(
                color: AppTheme.neonCyan,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          "LET'S BUILD\nSOMETHING.",
          style: TextStyle(
            fontSize: 30,
            height: 1.05,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.8,
          ),
        ),
        SizedBox(height: 13),
        Text(
          'Looking for an internship or an opportunity to '
          'learn, contribute and build real-world software.',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 12,
            height: 1.65,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailButton() {
    return InkWell(
      onTap: () => _launchUrl('mailto:arnob8855@gmail.com'),
      borderRadius: BorderRadius.circular(11),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
        decoration: BoxDecoration(
          color: AppTheme.neonPurple.withValues(alpha: 0.16),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: AppTheme.neonPurple.withValues(alpha: 0.35),
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.mail_outline_rounded,
              size: 16,
              color: AppTheme.neonCyan,
            ),
            SizedBox(width: 8),
            Text(
              'EMAIL ME',
              style: TextStyle(
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

  Widget _buildContactDetails(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900
            ? 3
            : constraints.maxWidth >= 600
            ? 2
            : 1;

        final cards = [
          ContactCard(
            icon: Icons.mail_outline_rounded,
            label: 'Email',
            value: 'arnob8855@gmail.com',
            onTap: () => _launchUrl('mailto:arnob8855@gmail.com'),
          ),
          ContactCard(
            icon: Icons.phone_outlined,
            label: 'WhatsApp',
            value: '+880 140 968 8763',
            onTap: () => _launchUrl('https://wa.me/8801409688763'),
          ),
          ContactCard(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: 'Dhaka, Bangladesh',
            onTap: () {},
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 76,
          ),
          itemBuilder: (_, index) => cards[index],
        );
      },
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              '© 2026 ARNOB DAS',
              style: TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 8,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Text(
            'BUILT WITH FLUTTER',
            style: TextStyle(
              color: AppTheme.textSecondary.withValues(alpha: 0.6),
              fontSize: 8,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  Widget _buildSocialLinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'FIND ME ONLINE',
          style: TextStyle(
            color: AppTheme.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 9,
          runSpacing: 9,
          children: [
            SocialLink(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              onTap: () => _launchUrl('https://github.com/code-silence'),
            ),
            SocialLink(
              icon: FontAwesomeIcons.linkedinIn,
              label: 'LinkedIn',
              onTap: () =>
                  _launchUrl('https://www.linkedin.com/in/arnob-das-b17870368'),
            ),
            SocialLink(
              icon: FontAwesomeIcons.facebookF,
              label: 'Facebook',
              onTap: () =>
                  _launchUrl('https://www.facebook.com/arnob.das.16906'),
            ),
            SocialLink(
              icon: FontAwesomeIcons.whatsapp,
              label: 'WhatsApp',
              onTap: () => _launchUrl('https://wa.me/8801409688763'),
            ),
            SocialLink(
              icon: FontAwesomeIcons.telegram,
              label: 'Telegram',
              onTap: () => _launchUrl('https://t.me/arnob8855'),
            ),
          ],
        ),
      ],
    );
  }
}

class _AboutStat extends StatelessWidget {
  final String number;
  final String label;

  const _AboutStat({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              number,
              style: const TextStyle(
                color: AppTheme.neonPurple,
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 7,
                letterSpacing: 1,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// SECTION CONTAINER
// ============================================================

class _SectionContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const _SectionContainer({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: _isMobile(context) ? 70 : 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppTheme.neonCyan,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: _isMobile(context) ? 26 : 34,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 40),
          child,
        ],
      ),
    );
  }

  bool _isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 700;
  }
}

// ============================================================
// ABOUT INFO
// ============================================================

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(
                color: AppTheme.neonPurple,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SKILL CARD
// ============================================================

class _SkillCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const _SkillCard({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppTheme.neonPurple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppTheme.neonCyan, size: 21),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// PROJECT CARD
// ============================================================

class _ProjectCard extends StatefulWidget {
  final String name;
  final String number;

  const _ProjectCard({required this.name, required this.number});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        transform: Matrix4.translationValues(0, hovering ? -5 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surface.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: hovering
                ? AppTheme.neonPurple.withValues(alpha: 0.65)
                : Colors.white.withValues(alpha: 0.07),
          ),
          boxShadow: hovering
              ? [
                  BoxShadow(
                    color: AppTheme.neonPurple.withValues(alpha: 0.12),
                    blurRadius: 25,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.number,
              style: const TextStyle(
                color: AppTheme.neonCyan,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
            const Spacer(),
            Text(
              widget.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'Project details coming soon.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// TIMELINE
// ============================================================

class _TimelineItem extends StatelessWidget {
  final String year;
  final String title;
  final String subtitle;
  final String description;

  const _TimelineItem({
    required this.year,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            year,
            style: const TextStyle(
              color: AppTheme.neonCyan,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: AppTheme.neonPurple,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: const TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// CONTACT CARD
// ============================================================

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _ContactCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.neonCyan, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppTheme.neonPurple,
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// ACTION BUTTON
// ============================================================

class _ActionButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _ActionButton({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: filled ? AppTheme.neonPurple : Colors.transparent,
        foregroundColor: Colors.white,
        side: BorderSide(
          color: filled
              ? AppTheme.neonPurple
              : AppTheme.neonCyan.withValues(alpha: 0.6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
