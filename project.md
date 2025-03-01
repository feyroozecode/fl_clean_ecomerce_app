Ecomer App
Directory Structure

lib/
└── src/
    └── features/
        └── ecomerce/
            ├── domain/
            │   ├── product.dart        # Product model
            │   └── cart_item.dart       # CartItem model
            ├── presentation/
            │   ├── product_list_screen.dart   # Screen to display the list of product
            │   ├── product_detail_screen.dart # Screen to display detail of product
            │   └── cart_screen.dart           # Screen to display the cart
            └─data/
                ├── product_repository.dart  # will provide the product list (fake now)
                └── cart_repository.dart  # will manage the cart (fake now)
            └── application/
                ├── product_controller.dart # will handle the product logic
                └── cart_controller.dart  # will handle the cart logic
        └── auth/ #Already exist
        └── home/ #Already exist
        └── task/ #Already exist
    └── core/ #Already exist
    └── commons/ #Already exist
Code Implementation

1. Domain Layer

lib/src/features/ecomerce/domain/product.dart
class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}
lib/src/features/ecomerce/domain/cart_item.dart
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  CartItem copyWith({int? quantity}) {
    return CartItem(product: product, quantity: quantity ?? this.quantity);
  }
}
2. Data Layer

lib/src/features/ecomerce/data/product_repository.dart
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';

class ProductRepository {
  List<Product> getProducts() {
    // In a real app, you would fetch this from an API or database.
    return [
      Product(
          id: '1',
          name: 'T-Shirt',
          description: 'A comfortable cotton t-shirt.',
          price: 19.99,
          imageUrl: 'https://via.placeholder.com/150'),
      Product(
          id: '2',
          name: 'Jeans',
          description: 'Stylish denim jeans.',
          price: 49.99,
          imageUrl: 'https://via.placeholder.com/150'),
      Product(
          id: '3',
          name: 'Sneakers',
          description: 'Modern and comfortable sneakers.',
          price: 79.99,
          imageUrl: 'https://via.placeholder.com/150'),
            Product(
          id: '4',
          name: 'Hoodie',
          description: 'Warm and cozy hoodie.',
          price: 39.99,
          imageUrl: 'https://via.placeholder.com/150'),
            Product(
          id: '5',
          name: 'Cap',
          description: 'Trendy baseball cap.',
          price: 14.99,
          imageUrl: 'https://via.placeholder.com/150'),
      // ... more products
    ];
  }
}
lib/src/features/ecomerce/data/cart_repository.dart
import 'package:todolistapp/src/features/ecomerce/domain/cart_item.dart';

class CartRepository{
  final List<CartItem> _cartItems = [];

  List<CartItem> getCartItems() => _cartItems;

  void addCartItem(CartItem item) {
    final existingItemIndex = _cartItems.indexWhere((element) => element.product.id == item.product.id);
    if (existingItemIndex >= 0) {
        _cartItems[existingItemIndex] = _cartItems[existingItemIndex].copyWith(quantity: _cartItems[existingItemIndex].quantity + 1);
      } else {
          _cartItems.add(item);
      }
  }

  void removeCartItem(CartItem item) {
      _cartItems.removeWhere((element) => element.product.id == item.product.id);
  }

    void updateCartItem(CartItem item) {
      final itemIndex = _cartItems.indexWhere((element) => element.product.id == item.product.id);
      _cartItems[itemIndex] = item;
  }

    void clearCart() {
      _cartItems.clear();
  }
}
3. Controller Layer

lib/src/features/ecomerce/controller/product_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/ecomerce/data/product_repository.dart';
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';

final productProvider = Provider<ProductController>((ref) => ProductController());

final productsProvider = Provider<List<Product>>((ref) {
    return ref.watch(productProvider).getProducts();
});

class ProductController {
  ProductController();

  ProductRepository productRepository = ProductRepository();

  List<Product> getProducts() {
    return productRepository.getProducts();
  }
}
lib/src/features/ecomerce/controller/cart_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/ecomerce/data/cart_repository.dart';
import 'package:todolistapp/src/features/ecomerce/domain/cart_item.dart';
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';

final cartControllerProvider = Provider<CartController>((ref) => CartController());

final cartItemsProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) => CartNotifier());

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    final existingItemIndex = state.indexWhere((element) => element.product.id == item.product.id);
    if (existingItemIndex >= 0) {
        state = [
        for(final items in state)
          if(items.product.id == item.product.id)
            items.copyWith(quantity: items.quantity + 1)
          else 
            items
        ];
      } else {
          state = [...state,item];
      }
  }
   void removeItem(CartItem item) {
      state = state.where((element) => element.product.id != item.product.id).toList();
  }

  void updateItem(CartItem item) {
    state = [
      for(final items in state)
        if(items.product.id == item.product.id)
          item
        else
          items
    ];
  }

    void clearItems() {
      state = [];
  }
}

class CartController {
    CartController();

    CartRepository cartRepository = CartRepository();

    List<CartItem> getItems() {
        return cartRepository.getCartItems();
    }
}

4. Presentation Layer

lib/src/features/ecomerce/presentation/product_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/ecomerce/controller/cart_controller.dart';
import 'package:todolistapp/src/features/ecomerce/controller/product_controller.dart';
import 'package:todolistapp/src/features/ecomerce/domain/cart_item.dart';
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';
import 'package:todolistapp/src/features/ecomerce/presentation/cart_screen.dart';
import 'package:todolistapp/src/features/ecomerce/presentation/product_detail_screen.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            onTap: (){
                 Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
              );
            },
            trailing: IconButton(
                onPressed: () {
                  ref.read(cartItemsProvider.notifier).addItem(CartItem(product: product));
                },
                icon: const Icon(Icons.add_shopping_cart)
              ),
          );
        },
      ),
    );
  }
}
Use code with care. Learn more
lib/src/features/ecomerce/presentation/product_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/ecomerce/controller/cart_controller.dart';
import 'package:todolistapp/src/features/ecomerce/domain/cart_item.dart';
import 'package:todolistapp/src/features/ecomerce/domain/product.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: Text(product.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product.imageUrl),
              const SizedBox(height: 10),
              Text(product.description,
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
               const SizedBox(height: 20),
              Center(
                child: IconButton(
                  onPressed: () {
                      ref.read(cartItemsProvider.notifier).addItem(CartItem(product: product));
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.orange),
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15))),
                ),
              ),
            ],
          ),
        ));
  }
}

Use code with care. Learn more
lib/src/features/ecomerce/presentation/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/ecomerce/controller/cart_controller.dart';
import 'package:todolistapp/src/features/ecomerce/domain/cart_item.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartItemsProvider);
    final total = cartItems.fold(0.0, (previousValue, element) => previousValue + (element.product.price * element.quantity));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl),
                  title: Text(item.product.name),
                  subtitle: Text('Quantity: ${item.quantity}'),
                  trailing: Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            ref.read(cartItemsProvider.notifier).addItem(CartItem(product: item.product));
                          },
                          icon: const Icon(Icons.add)),
                           IconButton(
                          onPressed: () {
                            if(item.quantity > 1) {
                                ref.read(cartItemsProvider.notifier).updateItem(item.copyWith(quantity: item.quantity -1));
                            } else {
                               ref.read(cartItemsProvider.notifier).removeItem(item);
                            }
                          },
                          icon: const Icon(Icons.remove)),
                          IconButton(
                          onPressed: () {
                             ref.read(cartItemsProvider.notifier).removeItem(item);
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                );
              },
            ),
            bottomNavigationBar: cartItems.isNotEmpty ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: \$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(cartItemsProvider.notifier).clearItems();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Cart is clear")));
                    },
                    child: const Text('Clear cart'),
                  ),
                ],
              ),
            ) : null,
    );
  }
}
Use code with care. Learn more
5. Update main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todolistapp/src/features/auth/presentation/signin_screen.dart';
import 'package:todolistapp/src/features/ecomerce/presentation/product_list_screen.dart';

// lancement de l'app -> Dart lance l'application Flutter
void main() => runApp( const ProviderScope(child: App()));

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TodoList',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      //home: const SigninScreen() // Previous start screen
      home: const ProductListScreen() // New start screen (e-commerce)
    );
  }
}
Use code with care. Learn more
Explanation and Key Improvements:

Layered Architecture: The code follows a layered approach (Domain, Data, Controller, Presentation), making it more maintainable and testable.
Riverpod for State Management:
productProvider: Provide the ProductController
productsProvider: Provide the product list
**`cartController
Rate this answer: 
External Sources (13)
Context Sources (8)
