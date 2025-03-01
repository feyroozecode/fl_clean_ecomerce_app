import 'package:ecomerce_app/src/features/home/presentaiton/home_screen.dart';
import 'package:flutter/material.dart';

import '../../common/app_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecomerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.commonColor),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    );
  }

}