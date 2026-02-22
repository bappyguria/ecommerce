import 'package:ecommerceapp/features/screens/wish_list/bloc/wish_list_bloc.dart';
import 'package:ecommerceapp/features/screens/wish_list/bloc/wish_list_event.dart';
import 'package:ecommerceapp/features/screens/wish_list/bloc/wish_list_state.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/prouct_ditals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {

  @override
  void initState() {
    super.initState();
    context.read<WishListBloc>().add(GetWishList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: AppBar(
        title: const Text("Wishlist"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: BlocBuilder<WishListBloc, WishListState>(
        builder: (context, state) {

          if (state is WishListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WishListError) {
            return Center(child: Text(state.message));
          }

          if (state is WishListLoaded) {

            if (state.wishListItems.isEmpty) {
              return const Center(
                child: Text(
                  "Your wishlist is empty",
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.wishListItems.length,
              itemBuilder: (context, index) {

                final item = state.wishListItems[index];
                final product = item.product;

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [

                      /// 🔹 Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: product?.photos != null &&
                                product!.photos!.isNotEmpty
                            ? Image.network(
                                product.photos!.first,
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                height: 80,
                                width: 80,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image),
                              ),
                      ),

                      const SizedBox(width: 16),

                      /// 🔹 Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Title
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => ProductDetailsScreen(
                                      productId: product?.id ?? "",
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                product?.title ?? "",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            /// Price
                            Text(
                              "৳ ${product?.currentPrice ?? 0}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1AA7A8),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 🔹 Remove Button
                      IconButton(
                        onPressed: () {
                        context.read<WishListBloc>().add(RemoveWishItem(item.id ?? ""));
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}