import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/technology_card.dart';

class TechnologiesSection extends StatelessWidget {
  const TechnologiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    return Container(
      width: double.infinity,
      color: AppColors.light,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.techTitle,
            subtitle: AppStrings.techSubtitle,
            description: 'We leverage modern, fast, and industry-standard technologies to ensure your applications are secure, performant, and future-proof.',
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Categories Grid
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCategoryGroup('Frontend', ['Flutter', 'React', 'Next.js'])),
                const SizedBox(width: 24),
                Expanded(child: _buildCategoryGroup('Backend', ['Node.js', 'Laravel', 'Firebase'])),
              ],
            ),
            mobile: Column(
              children: [
                _buildCategoryGroup('Frontend', ['Flutter', 'React', 'Next.js']),
                const SizedBox(height: 24),
                _buildCategoryGroup('Backend', ['Node.js', 'Laravel', 'Firebase']),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildCategoryGroup('Database', ['MySQL', 'PostgreSQL', 'MongoDB'])),
                const SizedBox(width: 24),
                Expanded(child: _buildCategoryGroup('Cloud', ['AWS', 'Google Cloud', 'Vercel'])),
              ],
            ),
            mobile: Column(
              children: [
                _buildCategoryGroup('Database', ['MySQL', 'PostgreSQL', 'MongoDB']),
                const SizedBox(height: 24),
                _buildCategoryGroup('Cloud', ['AWS', 'Google Cloud', 'Vercel']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGroup(String title, List<String> technologies) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withAlpha((0.08 * 255).toInt())),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.dark,
              fontWeight: FontWeight.w800,
              fontSize: 20,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 20),
          // Technologies list
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: technologies.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return TechnologyCard(
                name: technologies[index],
                category: title,
              );
            },
          ),
        ],
      ),
    );
  }
}
