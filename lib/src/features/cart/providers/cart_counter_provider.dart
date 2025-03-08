// lsite de produit dans le panier actuelle
import 'package:ecomerce_app/src/features/cart/providers/cart_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider pour le nombre actuelle des produits dans notre Panier (Cart)
final cartCounterProvider = StateProvider<int>((ref) {
  return ref.watch(cartProvider).length;
});
