import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_bloc.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_event.dart';
import 'package:ecommerceapp/features/screens/cart_list/bloc/cart_list_state.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/prouct_ditals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartListBloc>().add(LoadCartList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text("Cart"),
      ),
      body: BlocConsumer<CartListBloc, CartListState>(
        builder: (context, state) {
          if (state is CartListLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CartListError) {
            return Center(child: Text(state.message));
          }

          if (state is CartListLoaded) {
            final cartItems = state.cartItems;

            double total = 0;
            for (var item in cartItems) {
              total += (item.product?.currentPrice ?? 0) * (item.quantity ?? 0);
            }

            return Stack(
              children: [
                /// 🔹 Cart List
                Padding(
                  padding: const EdgeInsets.only(bottom: 120),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final product = item.product;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            /// Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:
                                  product?.photos != null &&
                                      product!.photos!.isNotEmpty
                                  ? Image.network(
                                      product.photos![0],
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

                            /// Product Details
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
                                          builder: (context) =>
                                              ProductDetailsScreen(
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

                                  const SizedBox(height: 6),

                                  /// Price
                                  Text(
                                    "\$${product?.currentPrice ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff1AA7A8),
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// Quantity Row
                                  Row(
                                    children: [
                                      _qtyButton(
                                        Icons.remove,
                                        Colors.grey.shade300,
                                        () {},
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Text(
                                          item.quantity.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      _qtyButton(
                                        Icons.add,
                                        const Color(0xff1AA7A8),
                                        () {},
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// Delete Icon
                            IconButton(
                              onPressed: () {
                                context.read<CartListBloc>().add(
                                  RemoveCartItem(item.id ?? ""),
                                );
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// 🔹 Bottom Total Section
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 110,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Color(0xffDCEFF0),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Total Price"),
                            const SizedBox(height: 6),
                            Text(
                              "\$${total.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1AA7A8),
                              ),
                            ),
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff1AA7A8),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Text(
                            "BUY NOW",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
        listener: (context, state) {
          if (state is CartItemRemoveSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Cart item removed successfully"),
                backgroundColor: Colors.green,
              ),
            );
          }

          if (state is CartItemRemoveError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _qtyButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 16,
          color: icon == Icons.add ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
