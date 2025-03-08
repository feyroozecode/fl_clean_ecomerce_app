import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/product.dart';

final productsProvider = Provider((ref) => [
      Product(
        name: 'Pack Standard V2',
        netPrice: 20,
        country: 'Niger',
        validity: 1,
        quantity: 10000,
        totalPrice: 200000,
        bonus: 100,
        description: 'Pack Standard Sawki WebSMS description',
      ),
      Product(
        name: 'Pack Business',
        netPrice: 18,
        country: 'Niger',
        validity: 3,
        quantity: 20000,
        totalPrice: 360000,
        bonus: 150,
        description: 'Pack Business Sawki WebSMS description',
      ),
      Product(
        name: 'Pack Premium',
        netPrice: 16,
        country: 'Niger',
        validity: 6,
        quantity: 50000,
        totalPrice: 800000,
        bonus: 200,
        description: 'Pack Premium Sawki WebSMS description',
      ),
      Product(
        name: 'Pack Sawki',
        netPrice: 14,
        country: 'Niger',
        validity: 12,
        quantity: 100000,
        totalPrice: 1400000,
        bonus: 500,
        description: 'Pack Sawki WebSMS description',
      ),
    ]);

