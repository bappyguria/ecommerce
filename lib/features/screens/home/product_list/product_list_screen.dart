
import 'package:ecommerceapp/features/data/models/product_model.dart';
import 'package:ecommerceapp/features/screens/widget/product_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

              if (state.productList.isEmpty) {
                return const Center(
                  child: Text(
                    "No products found in this category",
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }
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
                      context.push('/product-details/${product.id}');
                      print('Tapped on product: ${product.id}');
                    },
                    child: ProductCartItem(product: product),
                  
                  
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

