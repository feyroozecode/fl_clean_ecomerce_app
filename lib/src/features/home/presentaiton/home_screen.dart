import 'package:ecomerce_app/src/common/app_colors.dart';
import 'package:ecomerce_app/src/common/app_sizes.dart';
import 'package:ecomerce_app/src/features/home/domain/product.dart';
import 'package:flutter/material.dart';

import '../data/product_repository.dart';
import 'widgets/product_card.dart';

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
            padding: AppSizes.screenPadding,
            child: FutureBuilder<List<Product>>(

              // recuperation de la liste des produits 
              future: ProductRepository.getProducts(),
              
              builder: (context, snapshot) {
                // si la liste retorune des donnees
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length, // nombre de lignes
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // nombre de colonnes
                      mainAxisSpacing: 10, // espacement horizontal
                      crossAxisSpacing: 10, // espacement vertical
                      childAspectRatio: 1.0, // rapport hauteur/largeur
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: snapshot.data![index],
                      );
                    },
                  );
                } 
                // 
                else if (snapshot.hasError) {
                  return const Text('Erreur de chargement ');
                } 
                else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          
        )

        ],
      )
    );
  }
}