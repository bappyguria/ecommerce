import 'package:ecommerceapp/features/screens/home/popular/bloc/popular_item_bloc.dart';
import 'package:ecommerceapp/features/screens/home/popular/bloc/popular_item_event.dart';
import 'package:ecommerceapp/features/screens/home/popular/bloc/popular_item_state.dart';
import 'package:ecommerceapp/features/screens/widget/product_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../product_ditals/prouct_ditals_screen.dart';


class PopularItemList extends StatefulWidget {

  const PopularItemList({
    super.key,
    
  });

  @override
  State<PopularItemList> createState() => _PopularItemListState();
}

class _PopularItemListState extends State<PopularItemList> {
  @override
  void initState() {
    super.initState();
    context.read<PopularItemBloc>().add(
      GetPopularItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Popular Items")),
      body: BlocBuilder<PopularItemBloc, PopularItemState>(
        builder: (context, state) {
          if (state is PopularItemLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PopularItemLoaded) {
            return Padding(
              padding: const EdgeInsets.all(12),
              child: GridView.builder(
                itemCount: state.popularItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.60, // 👈 overflow fix
                ),
                itemBuilder: (context, index) {
                  final product = state.popularItems[index];

                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => ProductDetailsScreen(productId: product.id ?? ""),
                      ));
                    },
                    child: ProductCartItem(product: product),
                  
                  
                  );
                },
              ),
            );
          }

          if (state is PopularItemError) {
            return Center(child: Text(state.toString()));
          }

          return const SizedBox();
        },
      ),
    );
  }
}

