import 'package:flutter/material.dart';
import 'package:slash_store/main.dart';

class ShoppingCart {
  List<Product> items = [];
}

class ShoppingCartPage extends StatefulWidget {
  final ShoppingCart shoppingCart;

  const ShoppingCartPage({Key? key, required this.shoppingCart})
      : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  void removeProductFromCart(Product product) {
    setState(() {
      widget.shoppingCart.items.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Shopping Cart', // Your title here
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.shoppingCart.items.length,
              itemBuilder: (context, index) {
                final product = widget.shoppingCart.items[index];
                return Dismissible(
                  key: Key(product.id.toString()),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    removeProductFromCart(product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, width: 2.0), // Add border
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust border radius as needed
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(
                              0, 3), // Changes the position of the shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        product.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber),
                      ),
                      subtitle: Text(
                        product.description,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber),
                      ),
                      trailing: Text(
                        product.id.toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
