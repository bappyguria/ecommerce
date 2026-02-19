
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_ditals/prouct_ditals_screen.dart';
import 'bloc/product_list_bloc.dart';
import 'bloc/product_list_event.dart';
import 'bloc/product_list_state.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryId;
  final String categoryName;

  const ProductListScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductListBloc>().add(
      FetchProductsListByCategoryId(widget.categoryId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoryName)),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLodding) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LodedProductList) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: state.productList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.60, // 👈 overflow fix
                ),
                itemBuilder: (context, index) {
                  final product = state.productList[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(product: product),
                      ));
                    },
                    child: Container(
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
                    ),
                  );
                },
              ),
            );
          }

          if (state is ProductListError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
