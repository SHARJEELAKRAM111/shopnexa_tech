import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/project_model.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/portfolio_card.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'Mobile Banking Application',
      description:
          'A secure, biometric-enabled fintech app offering quick transfers, statements, and automated budgeting features.',
      imagePath: '',
      tags: ['Mobile App', 'Flutter', 'Firebase', 'REST API'],
      detailsUrl: '#',
    ),
    ProjectModel(
      title: 'E-Commerce Platform',
      description:
          'A premium, ultra-fast headless e-commerce system featuring multi-vendor panels and stripe integrated payments.',
      imagePath: '',
      tags: ['Web App', 'Next.js', 'Node.js', 'PostgreSQL'],
      detailsUrl: '#',
    ),
    ProjectModel(
      title: 'Healthcare Management System',
      description:
          'A cloud HIPAA-compliant portal enabling online doctor bookings, patient record analytics, and video consultations.',
      imagePath: '',
      tags: ['SaaS Platform', 'React', 'Firebase', 'Cloud'],
      detailsUrl: '#',
    ),
    ProjectModel(
      title: 'School Management System',
      description:
          'An all-in-one administration software tracking grades, online classrooms, class schedules, and parental updates.',
      imagePath: '',
      tags: ['Custom Software', 'Flutter Web', 'Node.js', 'MongoDB'],
      detailsUrl: '#',
    ),
    ProjectModel(
      title: 'CRM Dashboard',
      description:
          'An interactive company operations console analyzing lead pipelines, customer data, and sales charts.',
      imagePath: '',
      tags: ['Admin Panel', 'React', 'Laravel', 'MySQL'],
      detailsUrl: '#',
    ),
    ProjectModel(
      title: 'Delivery Tracking App',
      description:
          'A real-time logistics tracker with geofencing, route optimizations, push notifications, and courier mappings.',
      imagePath: '',
      tags: ['Mobile App', 'Flutter', 'Google Maps', 'Firebase'],
      detailsUrl: '#',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    // We adjust height calculations to prevent overflow issues
    final double childAspectRatio = isDesktop ? 0.8 : (isTablet ? 0.85 : 0.95);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.portfolioTitle,
            subtitle: AppStrings.portfolioSubtitle,
            description:
                'Some of our recently completed projects across mobile, web, and custom SaaS platforms. We build apps that scale.',
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Portfolio Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 30,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return PortfolioCard(project: projects[index]);
            },
          ),
        ],
      ),
    );
  }
}
