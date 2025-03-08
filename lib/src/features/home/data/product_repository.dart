import 'package:ecomerce_app/src/features/home/providers/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/product.dart';

class ProductRepository {
  
  static Future<List<Product>> getProducts(WidgetRef ref) async  => ref.read(productsProvider);
}