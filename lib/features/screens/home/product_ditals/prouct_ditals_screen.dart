import 'package:flutter/material.dart';

import '../../../data/models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedColor;
  String? selectedSize;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ""),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// PRODUCT IMAGE
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                (product.photos != null && product.photos!.isNotEmpty)
                    ? product.photos!.first
                    : "",
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TITLE
                  Text(
                    product.title ?? "",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  /// BRAND
                  Text(
                    product.brand?.title ?? "No Brand",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  /// PRICE
                  Text(
                    "৳ ${product.currentPrice ?? 0}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// COLOR SECTION
                  if (product.colors != null && product.colors!.isNotEmpty) ...[
                    const Text(
                      "Select Color",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: product.colors!.map((color) {
                        final isSelected = selectedColor == color;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedColor = color;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              color,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                  ],

                  /// SIZE SECTION
                  if (product.sizes != null && product.sizes!.isNotEmpty) ...[
                    const Text(
                      "Select Size",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      children: product.sizes!.map((size) {
                        final isSelected = selectedSize == size;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                              color: isSelected
                                  ? Colors.black
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                  ],

                  /// DESCRIPTION
                  Text(
                    product.description ?? "No description",
                    style: const TextStyle(fontSize: 16),
                  ),

                  const SizedBox(height: 30),

                  /// ADD TO CART
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        print("Selected Color: $selectedColor");
                        print("Selected Size: $selectedSize");
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
