import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../models/service_model.dart';
import '../responsive/responsive.dart';
import '../widgets/section_title.dart';
import '../widgets/service_card.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  static const List<ServiceModel> services = [
    ServiceModel(
      title: 'Mobile App Development',
      description: 'High-performance native and cross-platform apps built with Flutter for Android and iOS. Fluid user interfaces matched with robust architectures.',
      icon: Icons.phone_android,
    ),
    ServiceModel(
      title: 'Web Development',
      description: 'Fully responsive websites, custom enterprise web applications, and fast, scalable Single Page Apps optimized for speed and Search Engines.',
      icon: Icons.computer,
    ),
    ServiceModel(
      title: 'UI/UX Design',
      description: 'Premium designs that wow users. We construct interactive prototypes, style sheets, modern interfaces, and user-centered graphic assets.',
      icon: Icons.palette_outlined,
    ),
    ServiceModel(
      title: 'Backend Development',
      description: 'Secure architectures, custom web API integrations, databases management systems, server logic, and cloud-native authentications.',
      icon: Icons.dns_outlined,
    ),
    ServiceModel(
      title: 'SaaS Development',
      description: 'Multi-tenant cloud solutions, subscription billing architectures, custom administrative panels, and data analytics dashboards.',
      icon: Icons.business_outlined,
    ),
    ServiceModel(
      title: 'Maintenance & Support',
      description: 'System optimizations, version upgrades, security patches, features scaling, bug resolution, and continuous monitoring support.',
      icon: Icons.support_agent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);
    
    final int crossAxisCount = isDesktop ? 3 : (isTablet ? 2 : 1);
    final double horizontalPadding = isDesktop ? size.width * 0.08 : 24.0;
    
    // Calculate aspect ratio dynamically to prevent layout clipping
    final double childAspectRatio = isDesktop ? 1.25 : (isTablet ? 1.3 : 1.5);

    return Container(
      width: double.infinity,
      color: AppColors.light,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 80),
      child: Column(
        crossAxisAlignment: CenterPlaygroundAlign.getSectionAlignment(context),
        children: [
          const SectionTitle(
            title: AppStrings.servicesTitle,
            subtitle: AppStrings.servicesSubtitle,
            description: 'We offer comprehensive software development services to transform your ideas into scalable, secure, and production-ready applications.',
            isCenter: true,
          ),
          const SizedBox(height: 50),
          // Services Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              childAspectRatio: childAspectRatio,
            ),
            itemBuilder: (context, index) {
              return ServiceCard(service: services[index]);
            },
          ),
        ],
      ),
    );
  }
}

class CenterPlaygroundAlign {
  static CrossAxisAlignment getSectionAlignment(BuildContext context) {
    return CrossAxisAlignment.center;
  }
}
