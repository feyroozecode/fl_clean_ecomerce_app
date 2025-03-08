import 'package:ecomerce_app/src/common/app_colors.dart';
import 'package:ecomerce_app/src/common/app_sizes.dart';
import 'package:ecomerce_app/src/features/cart/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../details/presentation/product_details_screen.dart';
import '../../domain/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Scaffold(
            body: Padding(
                padding: AppSizes.screenPadding,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailScreen(
                                product: widget.product,
                              )),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name,
                          style: Theme.of(context).textTheme.titleLarge),
                      gapH2,
                      Text('P.U : ${widget.product.netPrice.toString()} XOF'),
                      gapH4,
                      Text('Quantité : ${widget.product.quantity.toString()}'),
                      gapH4,
                      Text(
                          'Validité : ${widget.product.validity.toString()} Mois'),
                      gapH4,
                      Text('Bonus : ${widget.product.bonus.toString()} XOF'),
                      gapH4,
                      Text(
                          'Prix Total : ${widget.product.totalPrice.toString()} XOF'),
                    ],
                  ),
                )),
            bottomNavigationBar: AddProductButton(
              product: widget.product,
            )));
  }
}

// Class pour notre buton d'ajout de produit a la liste du Panier

class AddProductButton extends ConsumerWidget {
  const AddProductButton({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: () {
          // creer un nouveau Produit pour ajout
          final newProduct = Product(
              name: product.name,
              netPrice: product.netPrice,
              country: product.country,
              validity: product.validity,
              quantity: product.quantity);

          // Ajout du nouveau produit
          ref.read(cartProvider.notifier).addProduct(newProduct);
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.add_shopping_cart,
              color: AppColors.commonColor,
            ),
          ],
        ),
      ),
    );
  }
}
