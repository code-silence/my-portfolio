import 'package:flutter/material.dart';

import '../models/project.dart';

const portfolioProjects = [
  Project(
    name: 'BD Railway Ticket Automation',
    description: 'A Bangladesh Railway ticket booking automation system.',
    technologies: ['Python', 'Playwright'],
    category: ProjectCategory.automation,
    imagePath: 'assets/images/projects/railway_ticket_automation.png',
    placeholderIcon: Icons.train_rounded,
    featured: true,
  ),

  Project(
    name: 'WatchNest',
    description:
        'A YouTube watch party application for watching videos together.',
    technologies: ['Flutter', 'Firebase'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/watch_nest.jpg',
    placeholderIcon: Icons.play_circle_outline_rounded,
    featured: true,
    githubUrl: 'https://github.com/code-silence/watch-party-app-using-flutter',
  ),

  Project(
    name: 'BlueWear',
    description: 'A modern e-commerce website for a clothing store.',
    technologies: ['HTML', 'CSS', 'JavaScript', 'Firebase'],
    category: ProjectCategory.website,
    imagePath: 'assets/images/projects/bluewear.png',
    placeholderIcon: Icons.shopping_bag_outlined,
    featured: true,
    githubUrl:
        'https://github.com/Three-Bugs-Zero-Fix/ecommerce-web-clothing-store',
  ),

  Project(
    name: 'PurpleChat',
    description: 'A real-time social chat application.',
    technologies: ['Flutter', 'Firebase'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/purplechat.png',
    placeholderIcon: Icons.forum_outlined,
    githubUrl: 'https://github.com/code-silence/a-flutter-chat-app-purple-chat',
  ),

  Project(
    name: 'Roxy',
    description: 'An AI-powered chat application with Gemini API integration.',
    technologies: ['Flutter', 'Gemini API'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/roxy.png',
    placeholderIcon: Icons.auto_awesome_rounded,
    githubUrl: 'https://github.com/code-silence/ai-chat-bot-flutter',
  ),

  Project(
    name: 'Draw What',
    description: 'A drawing and guessing game where one friend draws and others try to guess.',
    technologies: ['HTML', 'CSS', 'JavaScript', 'Firebase'],
    category: ProjectCategory.website,
    imagePath: 'assets/images/projects/draw_what.png',
    placeholderIcon: Icons.draw_rounded,
    githubUrl: 'https://github.com/code-silence/draw-what',
  ),

  Project(
    name: 'Pocket Pilot',
    description: 'A personal expense tracking application.',
    technologies: ['Flutter'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/pocket_pilot.png',
    placeholderIcon: Icons.account_balance_wallet_outlined,
    githubUrl: 'https://github.com/code-silence/expense-tracker-flutter',
  ),

  Project(
    name: 'SkyCast-Weather App',
    description: 'A weather application with location-based forecasts.',
    technologies: ['Flutter', 'REST API'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/skycast.png',
    placeholderIcon: Icons.cloud_outlined,
    githubUrl: 'https://github.com/code-silence/weather-app-flutter',
  ),

  Project(
    name: 'Cmdly',
    description: 'A developer command toolkit app for developers.',
    technologies: ['React', 'Expo'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/cmdly.png',
    placeholderIcon: Icons.terminal_rounded,
    githubUrl:
        'https://github.com/code-silence/dev-commands-a-react-native-app',
  ),

  Project(
    name: 'Developer Pocket',
    description: 'An offline developer utility toolkit.',
    technologies: ['Flutter', 'Riverpod'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/developer_pocket.png',
    placeholderIcon: Icons.build_circle_outlined,
    githubUrl: 'https://github.com/code-silence/devpal-developer-s-calculator',
  ),

  Project(
    name: 'StudentFlow',
    description: 'A student progress tracking application designed for teachers to monitor student performance.',
    technologies: ['Flutter', 'Local Storage'],
    category: ProjectCategory.app,
    imagePath: 'assets/images/projects/student_flow.png',
    placeholderIcon: Icons.school_rounded,
    githubUrl: 'https://github.com/code-silence/student-flow-app',
  ),
];
