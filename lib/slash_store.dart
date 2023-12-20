// ignore_for_file: library_private_types_in_public_api, prefer_collection_literals, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slash_store/image_carousel.dart';
import 'package:slash_store/main.dart';

class SlashStore extends StatelessWidget {
  const SlashStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Slash.', // Your title here
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: const ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late Future<List<Product>> products;
  Set<Product> favorites = Set<Product>();
  late List<dynamic>
      productJsonResponse; // Add this line to store the JSON response

  @override
  void initState() {
    super.initState();
    products = fetchProducts();
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://slash-backend.onrender.com/product'));
    if (response.statusCode == 200) {
      productJsonResponse =
          json.decode(response.body)['data']; // Store the JSON response
      print('Raw JSON data: $productJsonResponse'); // Print raw JSON data
      try {
        return productJsonResponse
            .map((json) => Product.fromJson(json))
            .toList();
      } catch (e) {
        print('Error parsing JSON: $e');
        throw Exception('Failed to load products');
      }
    } else {
      throw Exception('Failed to load products');
    }
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (favorites.contains(product)) {
        favorites.remove(product);
        print(favorites);

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text('Removed from Favorites'),
              content:
                  Text('${product.name} removed from your favorites list.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.blue), // Custom text color
                  ),
                ),
              ],
            );
          },
        );
      } else {
        favorites.add(product);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: const Text('Added to Favorites'),
              content: Text('${product.name} added to your favorites list.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(color: Colors.blue), // Custom text color
                  ),
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: products,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 20.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Product product = snapshot.data![index];
              List<String> nameWords = product.name.split(' ');
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageCarousel(
                          imagePaths:
                              product.getProductImages(productJsonResponse),
                          brandLogo: product.brandLogo,
                          des: product.description,
                          id: product.id,
                          name: product.name,
                          prices: product.prices,
                          brandName: product.brandName,
                        ),
                      ));
                },
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      color: Colors.white, // Set background color to black
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            child: Image.network(
                              product.imagePath,
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                    Icons.error); // Placeholder for error
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          '${product.brandName} - ${nameWords.join("\n")}',
                          maxLines: 2,
                          style: const TextStyle(
                            color: Colors.white,
                            // Limit to 2 lines
                            overflow: TextOverflow
                                .ellipsis, // Show ellipsis (...) for overflow // Set text color to white
                          ),
                        ),
                        Image.network(
                          product.brandLogo,
                          width: 30,
                          height: 30,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'EGP ${product.prices.join(", ")}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              toggleFavorite(product);
                            });
                          },
                          icon: Icon(
                            favorites.contains(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: favorites.contains(product)
                                ? Colors.red
                                : Colors.white,
                          ),
                        ),
                        const Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
