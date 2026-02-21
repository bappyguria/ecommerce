import 'package:ecommerceapp/features/data/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCartItem extends StatelessWidget {
  const ProductCartItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          10,
        ), // 👈 radius কমানো
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // 👈 LEFT START
        children: [
          /// IMAGE
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10), // 👈 same radius
              ),
              child: Container(
                width: double.infinity,
                color: const Color(0xFFE6F4F2),
                child: Image.network(
                  (product.photos != null &&
                          product.photos!.isNotEmpty)
                      ? product.photos!.first
                      : "",
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          ),
    
          /// INFO
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // 👈 LEFT ALIGN
              children: [
                /// TITLE
                Text(
                  product.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left, // 👈 force left
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
    
                const SizedBox(height: 6),
                Text(
                  "\$${product.currentPrice ?? 0}",
                  style: const TextStyle(
                    color: Color(0xFF00BFA5),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
    
                /// PRICE + RATING
                Row(
                  children: [
                    
                    const Icon(
                      Icons.star,
                      size: 13,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 2),
                    const Text(
                      "4.8",
                      style: TextStyle(fontSize: 11),
                    ),
    
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00BFA5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
