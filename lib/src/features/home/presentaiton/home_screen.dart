import 'package:ecomerce_app/src/common/app_colors.dart';
import 'package:ecomerce_app/src/common/app_sizes.dart';
import 'package:ecomerce_app/src/features/cart/presentation/cart_screen.dart';
import 'package:ecomerce_app/src/features/cart/providers/cart_counter_provider.dart';
import 'package:ecomerce_app/src/features/home/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../details/presentation/product_details_screen.dart';
import '../data/product_repository.dart';
import 'widgets/product_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final totalCartItems = ref.watch(cartCounterProvider);

    print("add $totalCartItems");

    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.screenBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.commonColor,
        title: const Text(
          'Sawki WebSMS',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 10,
      ),
      body: Column(
        children: [
          // welcome card
          Container(
              height: size.height * 0.3,
              width: size.width,
              color: AppColors.secondaryColor,
              child: const Center(
                child: Text(
                  'Pack Sawki WebSMS',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              )),

          // product list card
          Container(
            height: size.height * 0.7 - kToolbarHeight,
            padding: AppSizes.screenPadding,
            child: FutureBuilder<List<Product>>(
              // recuperation de la liste des produits
              future: ProductRepository.getProducts(ref),

              builder: (context, snapshot) {
                // si la liste retorune des donnees
                if (snapshot.hasData) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length, // nombre de lignes
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
        backgroundColor: AppColors.commonColor,
        child: Badge.count(
          count: totalCartItems,
          isLabelVisible: true,
          alignment: Alignment.topRight,
          child: const Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
