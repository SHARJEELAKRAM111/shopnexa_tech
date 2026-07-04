import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';

class WhyChooseUsSection extends StatelessWidget {
  const WhyChooseUsSection({super.key});

  static const List<FeatureItem> features = [
    FeatureItem(
      title: 'Experienced Team',
      desc: 'Our engineers and designers have years of experience building production-level systems.',
      icon: Icons.groups_outlined,
    ),
    FeatureItem(
      title: 'Modern Technologies',
      desc: 'We use the latest tech stacks to deliver highly performant and secure platforms.',
      icon: Icons.biotech_outlined,
    ),
    FeatureItem(
      title: 'Scalable Architecture',
      desc: 'We design software that scales smoothly with your business user-growth requirements.',
      icon: Icons.schema_outlined,
    ),
    FeatureItem(
      title: 'Fast Delivery',
      desc: 'Our agile processes ensure high-velocity delivery without sacrificing quality standards.',
      icon: Icons.speed_outlined,
    ),
    FeatureItem(
      title: 'Quality Assurance',
      desc: 'Rigorous manual and automated testing flows ensure stable and bug-free releases.',
      icon: Icons.fact_check_outlined,
    ),
    FeatureItem(
      title: 'Long-Term Support',
      desc: 'We support you after launch with optimization, maintenance, and future updates.',
      icon: Icons.handshake_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;
    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    
    // Determine card aspect ratio
    final double childAspectRatio = isDesktop ? 1.45 : (isTablet ? 1.4 : 1.6);

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.whyChooseUsTitle,
            subtitle: AppStrings.whyChooseUsSubtitle,
            description: 'We strive to build long-term relationships with our clients by providing high-quality software, transparent communications, and timely executions.',
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Features Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return _buildFeatureCard(features[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(FeatureItem item) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.light,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isHovered 
                    ? AppColors.primary.withAlpha((0.35 * 255).toInt()) 
                    : Colors.grey.withAlpha((0.08 * 255).toInt()),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: isHovered 
                      ? AppColors.primary.withAlpha((0.08 * 255).toInt()) 
                      : Colors.black.withAlpha((0.02 * 255).toInt()),
                  blurRadius: isHovered ? 20 : 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Glowing Icon box
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isHovered 
                        ? AppColors.primary 
                        : AppColors.primary.withAlpha((0.08 * 255).toInt()),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    item.icon,
                    color: isHovered ? AppColors.light : AppColors.primary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 20),
                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: AppColors.dark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          item.desc,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FeatureItem {
  final String title;
  final String desc;
  final IconData icon;

  const FeatureItem({
    required this.title,
    required this.desc,
    required this.icon,
  });
}
