import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme.dart';

class ShopNexaApp extends StatelessWidget {
  const ShopNexaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopNexa Technologies | Mobile & Web Development Company',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.home,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
