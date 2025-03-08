import 'package:ecomerce_app/src/features/home/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// definition de type de retour pour la lsite de produit bonne pratique
typedef ProductList = List<Product>;

// Class pour gerer la reactiviter du Panier du cout on utilise StateNotifier
class CartNotifier extends StateNotifier<ProductList> {
  CartNotifier() : super([]);

  void addProduct(Product product) {
    state = [...state, product];
    print("add product ${product.name}");
  }
}

// enfin Notre provider pour acceder et modifer notre Panier
final cartProvider = StateNotifierProvider<CartNotifier, ProductList>((ref) {
  return CartNotifier();
});
