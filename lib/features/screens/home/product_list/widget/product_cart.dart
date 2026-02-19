import 'package:flutter/material.dart';

class ProductListUIScreen extends StatelessWidget {
  const ProductListUIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BFA5),
        elevation: 0,
        title: const Text("Electronics"),
        leading: const Icon(Icons.arrow_back),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: 12,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.72,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// IMAGE AREA
                  Container(
                    height: 110,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE6F4F2),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/shoe.png',
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  /// INFO AREA
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE
                        const Text(
                          "New Year Special Shoe 30",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),

                        const SizedBox(height: 6),

                        /// PRICE + RATING + FAV
                        Row(
                          children: [
                            const Text(
                              "\$100",
                              style: TextStyle(
                                color: Color(0xFF00BFA5),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(width: 6),

                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),

                            const SizedBox(width: 2),

                            const Text("4.8", style: TextStyle(fontSize: 12)),

                            const Spacer(),

                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: const Color(0xFF00BFA5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: 14,
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
          },
        ),
      
      
      
      ),
    );
  }
}
