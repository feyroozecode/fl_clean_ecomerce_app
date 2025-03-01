import 'package:ecomerce_app/src/common/app_color.dart';
import 'package:ecomerce_app/src/common/app_size.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.commonColor,
        title: const Text('Sawki WebSMS'),
        elevation: 10,
      ),
      body: Column(
        children: [
          // welcome card
          Container(
            height: size.height * 0.3,
            width: size.width,
            color: AppColors.secondaryColor,
            child: const Center(child: Text(
              'Pack Sawki WebSMS', 
              style: TextStyle(color: Colors.white, fontSize: 24),),
            )
          ),

          // product list card
          Container(
            height: size.height * 0.7 - kToolbarHeight,
            padding: AppSize.screenPadding,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.0,
              ),
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Product ${index + 1}'),
                  ),
                );
              },
          )
          )
        ],
      )
    );
  }
}