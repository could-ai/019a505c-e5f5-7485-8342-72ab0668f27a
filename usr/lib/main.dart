import 'package:flutter/material.dart';
import 'models/product.dart';
import 'widgets/product_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winners Mobiles',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const ProductCatalogScreen(),
    );
  }
}

class ProductCatalogScreen extends StatefulWidget {
  const ProductCatalogScreen({super.key});

  @override
  State<ProductCatalogScreen> createState() => _ProductCatalogScreenState();
}

class _ProductCatalogScreenState extends State<ProductCatalogScreen> {
  final List<Product> _products = [
    Product(id: 'iphone-15', name: 'iPhone 15 Pro (256GB)', price: 999.99, category: 'Mobiles', imageUrl: 'https://placehold.co/400x400/1e40af/ffffff?text=iPhone+15'),
    Product(id: 'galaxy-s24', name: 'Galaxy S24 Ultra (512GB)', price: 1199.99, category: 'Mobiles', imageUrl: 'https://placehold.co/400x400/1e40af/ffffff?text=Galaxy+S24'),
    Product(id: 'airpods-pro', name: 'AirPods Pro (2nd Gen)', price: 249.00, category: 'Accessories', imageUrl: 'https://placehold.co/400x400/4f46e5/ffffff?text=AirPods+Pro'),
    Product(id: 'anker-powerbank', name: 'Anker PowerCore 20K', price: 45.50, category: 'Accessories', imageUrl: 'https://placehold.co/400x400/4f46e5/ffffff?text=PowerBank'),
    Product(id: 'pixel-8', name: 'Google Pixel 8 (128GB)', price: 699.00, category: 'Mobiles', imageUrl: 'https://placehold.co/400x400/1e40af/ffffff?text=Pixel+8'),
    Product(id: 'charger-cable', name: 'USB-C Fast Charge Cable', price: 15.99, category: 'Accessories', imageUrl: 'https://placehold.co/400x400/4f46e5/ffffff?text=USB-C+Cable'),
  ];

  final Map<String, int> _cart = {};

  void _addToCart(Product product) {
    setState(() {
      _cart.update(product.id, (value) => value + 1, ifAbsent: () => 1);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  int get _cartItemCount {
    return _cart.values.fold(0, (sum, quantity) => sum + quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WINNERS MOBILES',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart, color: Colors.white),
                  onPressed: () {
                    // TODO: Navigate to cart screen
                  },
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    right: 4,
                    top: 4,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$_cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Mobile & Accessories Catalog',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400.0,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final product = _products[index];
                  return ProductCard(
                    product: product,
                    onAddToCart: () => _addToCart(product),
                  );
                },
                childCount: _products.length,
              ),
            ),
          ),
           SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 32),
              padding: const EdgeInsets.all(24.0),
              color: const Color(0xFF1F2937),
              child: const Column(
                children: [
                  Text(
                    '© 2024 Winners Mobiles. All rights reserved.',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Powered by Flutter',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
