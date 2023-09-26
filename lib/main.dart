import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  proListState createState() => proListState();
}

class proListState extends State<ProductList> {

  List<Product> products = [
    Product(name: "Product", price: 10, id: 01),
    Product(name: "Product ", price: 20, id: 02),
    Product(name: "Product ", price: 30,id: 03),
    Product(name: "Product ", price: 20,id: 04),
    Product(name: "Product ", price: 30,id: 05),
    Product(name: "Product ", price: 20,id: 06),
    Product(name: "Product ", price: 10,id: 07),
    Product(name: "Product ", price: 20,id: 08),
    Product(name: "Product ", price: 10,id: 09),
    Product(name: "Product ", price: 40,id: 10),
    Product(name: "Product ", price: 20,id: 11),
    Product(name: "Product ", price: 10,id: 12),
    Product(name: "Product ", price: 30,id: 13),
    Product(name: "Product ", price: 20,id: 14),
    Product(name: "Product ", price: 30,id: 15),
  ];



  @override
  Widget build(BuildContext context) {
     return Scaffold(
       floatingActionButton: FloatingActionButton(

         child: Icon(Icons.shopping_cart),
           onPressed: () {
             Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => CartPage(products: products)),
             );
           }
       ),
       appBar: AppBar(
         centerTitle: true,
         title: Text("Product List"),
       ),
       body:
       ListView.builder(
               itemExtent: 80,
               itemCount: products.length,
               itemBuilder: (context, index) {
                 return ProductItem(product: products[index]);
               })
           );




  }

}

class Product {

  final String name;
  final int id;
  final double price;
  int count = 0;

  Product({required this.name,required this.id, required this.price});
}

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem({required this.product});

  @override
  proItemState createState() => proItemState();
}

class proItemState extends State<ProductItem> {


  void buyPro() {
    setState(() {
      widget.product.count++;
      if (widget.product.count >= 5) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Congratulations!"),
              content: Text("You've bought 5 ${widget.product.name}!"),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
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
    return SingleChildScrollView(
      child: ListTile(

        title: Text('${widget.product.name} ${widget.product.id}'),
        subtitle: Text("\$${widget.product.price.toStringAsFixed(2)}"),
        trailing: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: Column(
                children: [
                  Text("Count: ${widget.product.count}",style: TextStyle(fontSize: 12),),
                  //SSizedBox(width: 10),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                      onPressed: buyPro,
                      child: Text("Buy Now",style: TextStyle(fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class CartPage extends StatelessWidget {
  final List<Product> products;

  CartPage({required this.products});

  int getTotalCount() {
    int totalCount = 0;
    for (var product in products) {
      totalCount += product.count;
    }
    return totalCount;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Page"),
      ),
      body: Center(
        child: Text("Total Products Bought: ${getTotalCount()}"),
      ),
    );
  }
}