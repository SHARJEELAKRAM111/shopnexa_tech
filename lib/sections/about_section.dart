import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/animated_counter.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SectionTitle(
            title: AppStrings.aboutTitle,
            subtitle: 'WHO WE ARE',
            description: AppStrings.aboutContent,
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Mission, Vision, Values Cards
          Responsive(
            desktop: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildValueCard(AppStrings.missionTitle, AppStrings.missionDesc, Icons.track_changes, AppColors.primary)),
                const SizedBox(width: 24),
                Expanded(child: _buildValueCard(AppStrings.visionTitle, AppStrings.visionDesc, Icons.visibility_outlined, AppColors.secondary)),
                const SizedBox(width: 24),
                Expanded(child: _buildValueCard(AppStrings.valuesTitle, AppStrings.valuesDesc, Icons.favorite_border, AppColors.accent)),
              ],
            ),
            mobile: Column(
              children: [
                _buildValueCard(AppStrings.missionTitle, AppStrings.missionDesc, Icons.track_changes, AppColors.primary),
                const SizedBox(height: 20),
                _buildValueCard(AppStrings.visionTitle, AppStrings.visionDesc, Icons.visibility_outlined, AppColors.secondary),
                const SizedBox(height: 20),
                _buildValueCard(AppStrings.valuesTitle, AppStrings.valuesDesc, Icons.favorite_border, AppColors.accent),
              ],
            ),
          ),
          const SizedBox(height: 60),
          // Statistics Panel
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha((0.2 * 255).toInt()),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: Responsive(
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(50, '+', AppStrings.statProjectsLabel),
                  _buildDivider(vertical: true),
                  _buildStatItem(20, '+', AppStrings.statClientsLabel),
                  _buildDivider(vertical: true),
                  _buildStatItem(5, '+', AppStrings.statYearsLabel),
                  _buildDivider(vertical: true),
                  _buildStatItem(100, '%', AppStrings.statCommitmentLabel),
                ],
              ),
              mobile: Column(
                children: [
                  _buildStatItem(50, '+', AppStrings.statProjectsLabel),
                  _buildDivider(vertical: false),
                  _buildStatItem(20, '+', AppStrings.statClientsLabel),
                  _buildDivider(vertical: false),
                  _buildStatItem(5, '+', AppStrings.statYearsLabel),
                  _buildDivider(vertical: false),
                  _buildStatItem(100, '%', AppStrings.statCommitmentLabel),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildValueCard(String title, String desc, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.withAlpha((0.1 * 255).toInt()),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.02 * 255).toInt()),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha((0.1 * 255).toInt()),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.dark,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            desc,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(int endVal, String suffix, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedCounter(
          endValue: endVal,
          suffix: suffix,
          style: const TextStyle(
            color: AppColors.light,
            fontWeight: FontWeight.w900,
            fontSize: 48,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: AppColors.light.withAlpha((0.85 * 255).toInt()),
            fontWeight: FontWeight.w600,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider({required bool vertical}) {
    if (vertical) {
      return Container(
        height: 60,
        width: 1.5,
        color: AppColors.light.withAlpha((0.25 * 255).toInt()),
      );
    } else {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        height: 1.5,
        width: 80,
        color: AppColors.light.withAlpha((0.25 * 255).toInt()),
      );
    }
  }
}
