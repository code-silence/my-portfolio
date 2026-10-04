import 'package:flutter/material.dart';

enum ProjectCategory {
  all,
  app,
  website,
  automation,
}

class Project {
  final String name;
  final String description;
  final List<String> technologies;
  final ProjectCategory category;
  final String? imagePath;
  final IconData placeholderIcon;
  final bool featured;
  final String? githubUrl;
  final String? liveUrl;

  const Project({
    required this.name,
    required this.description,
    required this.technologies,
    required this.category,
    this.imagePath,
    required this.placeholderIcon,
    this.featured = false,
    this.githubUrl,
    this.liveUrl,
  });
}