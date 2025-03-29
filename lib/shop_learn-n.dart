import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductGrid(),
    );
  }
}

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  // Sample product data
  final List<Product> products = [
    Product(
      name: 'PEUGEOT - LR01',
      category: 'Road Bike',
      price: 1999.99,
      image: 'assets/road_bike.png',
      isFavorite: true,
      bgColor: const Color(0xFF2D3748),
    ),
    Product(
      name: 'SMITH - Trade',
      category: 'Road Helmet',
      price: 120.00,
      image: 'assets/helmet.png',
      isFavorite: false,
      bgColor: const Color(0xFF6B7280),
    ),
    Product(
      name: 'SMITH - Trade',
      category: 'Road Helmet',
      price: 120.00,
      image: 'assets/helmet.png',
      isFavorite: true,
      bgColor: const Color(0xFF6B7280),
    ),
    Product(
      name: 'PILOT - Chromoly',
      category: 'Mountain Bike',
      price: 1999.99,
      image: 'assets/mountain_bike.png',
      isFavorite: false,
      bgColor: const Color(0xFF6B7280),
    ),
    Product(
      name: 'PILOT - Chromoly',
      category: 'Mountain Bike',
      price: 1999.99,
      image: 'assets/mountain_bike.png',
      isFavorite: false,
      bgColor: const Color(0xFF6B7280),
    ),
    Product(
      name: 'SMITH - Trade',
      category: 'Road Helmet',
      price: 120.00,
      image: 'assets/helmet.png',
      isFavorite: false,
      bgColor: const Color(0xFF6B7280),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: products.map((product) {
              return ProductCard(product: product);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 240,
      decoration: BoxDecoration(
        color: product.bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                product.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String category;
  final double price;
  final String image;
  bool isFavorite;
  final Color bgColor;

  Product({
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.isFavorite,
    required this.bgColor,
  });
}
