import 'package:ecomerce_app/src/features/home/domain/product.dart';
import 'package:flutter/material.dart';

import '../../../common/app_sizes.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});
  final Product product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.product.name,
              style: Theme.of(context).textTheme.titleLarge),
          gapH2,
          Text('P.U : ${widget.product.netPrice.toString()} XOF'),
          gapH4,
          Text('Quantité : ${widget.product.quantity.toString()}'),
          gapH4,
          Text('Validité : ${widget.product.validity.toString()} Mois'),
          gapH4,
          Text('Bonus : ${widget.product.bonus.toString()} XOF'),
          gapH4,
          Text('Prix Total : ${widget.product.totalPrice.toString()} XOF'),
        ],
      ),
    );
  }
}
