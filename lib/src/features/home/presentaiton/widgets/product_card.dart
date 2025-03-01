
import 'package:ecomerce_app/src/common/app_colors.dart';
import 'package:ecomerce_app/src/common/app_sizes.dart';
import 'package:flutter/material.dart';

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
      child:  Scaffold(
        body: Padding(
          padding: AppSizes.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.product.name, style: Theme.of(context).textTheme.titleLarge),
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
        ),
        bottomNavigationBar: Container(
          child: GestureDetector(
            onTap: () {},
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add_shopping_cart, color: AppColors.commonColor,),
              ],
            ),
          
          ),
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          
        )
      )
    );
  }
}