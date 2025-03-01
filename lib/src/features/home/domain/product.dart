

class Product {
  final String name;
  final double netPrice;
  final String country;
  final int validity;
  final int quantity;
  final int bonus;
  final double totalPrice;
  final String? description;
  
  Product({
    required this.name,
    required this.netPrice,
    required this.country,
    required this.validity,
    required this.quantity,
    this.totalPrice = 0,
    this.bonus = 0,
    this.description,
  });
}