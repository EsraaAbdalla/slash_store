import 'package:flutter/material.dart';
import 'package:slash_store/slash_store.dart';

void main() {
  runApp(const SlashStore());
}

class Product {
  final int id; // Added id property
  final String name;
  final List<int> prices;
  final String imagePath;
  final String brandName;
  final String brandLogo;
  final String description; // Added description property

  Product({
    required this.id,
    required this.name,
    required this.prices,
    required this.imagePath,
    required this.brandName,
    required this.brandLogo,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<dynamic> variations = json['ProductVariations'];
    final List<int> prices =
        variations.map((variation) => variation['price'] as int).toList();

    return Product(
      id: json['id'] as int, // Added id property
      name: json['name'] as String,
      prices: prices,
      imagePath:
          variations[0]['ProductVarientImages'][0]['image_path'] as String,
      brandName: json['Brands']['brand_name'] as String,
      brandLogo: json['Brands']['brand_logo_image_path'] as String,
      description:
          json['description'] as String, // Added description assignment
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, prices: $prices, imagePath: $imagePath, brandName: $brandName, brandLogo: $brandLogo)';
  }

  List<String> getProductImages(List<dynamic> products) {
    final product = products.firstWhere(
      (p) => p['name'] == name && p['id'] == id,
      orElse: () => {},
    );

    if (product.isNotEmpty) {
      final productVariations = product['ProductVariations'] as List<dynamic>;
      final List<String> imagePaths = productVariations
          .map((variation) =>
              (variation['ProductVarientImages'] as List<dynamic>)
                  .map((image) => image['image_path'].toString())
                  .toList())
          .expand((images) => images)
          .toList();

      return imagePaths;
    }

    return [];
  }
}
