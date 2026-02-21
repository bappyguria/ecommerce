import 'package:carousel_slider/carousel_slider.dart';

import 'package:ecommerceapp/features/screens/add_cart/add_cart_bloc.dart';
import 'package:ecommerceapp/features/screens/add_cart/add_cart_event.dart';
import 'package:ecommerceapp/features/screens/add_cart/add_cart_state.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/bloc/product_detals_bloc.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/bloc/product_detals_event.dart';
import 'package:ecommerceapp/features/screens/home/product_ditals/bloc/product_detals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? selectedColor;
  String? selectedSize;
  int quantity = 1;
  int currentIndex = 0;
  bool isAddingToCart = false;

  @override
  void initState() {
    super.initState();
    // Fetch product details when the screen is initialized
    context.read<ProductDetalsBloc>().add(GetProductDetails(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 🔥 Bottom Price Bar
      body: BlocBuilder<ProductDetalsBloc, ProductDetalsState>(
        builder: (context, state) {
          if (state is ProductDetalsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductDetalsLoaded) {
            final product = state.product;
            final images = product.photos ?? [];

            return Column(
              children: [
                /// 🔥 IMAGE SECTION (Grey Background Like Screenshot)
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: images.isEmpty
                      ? const Icon(Icons.image, size: 80)
                      : images.length == 1
                      ? Image.network(images.first, fit: BoxFit.contain)
                      : CarouselSlider(
                          options: CarouselOptions(
                            height: 300,
                            viewportFraction: 1,
                            autoPlay: false,
                            onPageChanged: (index, _) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                          ),
                          items: images.map((img) {
                            return Image.network(img, fit: BoxFit.cover);
                          }).toList(),
                        ),
                ),

                /// 🔥 SCROLLABLE DETAILS
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TITLE + QUANTITY
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                product.title ?? "",
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            Row(
                              children: [
                                _qtyButton(Icons.remove, () {
                                  if (quantity > 1) {
                                    setState(() => quantity--);
                                  }
                                }),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                _qtyButton(Icons.add, () {
                                  setState(() => quantity++);
                                }),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        /// BRAND
                        if (product.brand?.title != null)
                          Text(
                            product.brand!.title!,
                            style: const TextStyle(color: Colors.grey),
                          ),

                        const SizedBox(height: 15),

                        /// RATING ROW
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 6),
                            const Text("4.8"),
                            const SizedBox(width: 12),
                            Text(
                              "Reviews",
                              style: TextStyle(color: Colors.teal.shade700),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        /// COLOR
                        if (product.colors?.isNotEmpty ?? false) ...[
                          const Text(
                            "Color",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 12,
                            children: product.colors!.map((color) {
                              final isSelected = selectedColor == color;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print("Selected Color: $color");
                                    selectedColor = color;
                                  });
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: getColorFromName(
                                      color,
                                    ), // 🔥 dynamic color
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.teal
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 25),
                        ],

                        /// SIZE
                        if (product.sizes?.isNotEmpty ?? false) ...[
                          const Text(
                            "Size",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            children: product.sizes!.map((size) {
                              final isSelected = selectedSize == size;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    print('Selected Size: $size');
                                    selectedSize = size;
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.teal
                                          : Colors.grey,
                                    ),
                                    color: isSelected
                                        ? Colors.teal
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    size,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 25),
                        ],

                        /// DESCRIPTION
                        if (product.description != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.description!,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  height: 1.5,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),

                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),

                /// 🔥 BOTTOM BAR
                Container(
                  height: 90,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4F3),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// PRICE
                      if (product.currentPrice != null)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              "৳ ${product.currentPrice}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            if (product.regularPrice != null)
                              Text(
                                "৳ ${product.regularPrice}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                          ],
                        ),

                      /// ADD TO CART BUTTON
                      BlocConsumer<AddCartBloc, AddCartState>(
                        listener: (context, state) {
                          if (state is AddCartSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }

                          if (state is AddCartFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.error)),
                            );
                          }
                        },

                        builder: (context, state) {
                          if (state is AddCartLoading) {
                            return const CircularProgressIndicator();
                          }
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () {
                              print("Color: $selectedColor");
                              print("Size: $selectedSize");
                              print("Quantity: $quantity");
                              context.read<AddCartBloc>().add(
                                AddToCartEvent(productId: product.id ?? ""),
                              );
                            },
                            child: const Text(
                              "Add To Cart",
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is ProductDetalsError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback onTap) {
    return Container(
      width: 25,
      height: 20,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, size: 16, color: Colors.white),
        onPressed: onTap,
      ),
    );
  }
}

Color getColorFromName(String colorName) {
  switch (colorName.toLowerCase()) {
    case "red":
      return Colors.red;
    case "blue":
      return Colors.blue;
    case "green":
      return Colors.green;
    case "purple":
      return Colors.purple;
    case "gold":
      return Colors.amber;
    case "black":
      return Colors.black;
    case "white":
      return Colors.white;
    case "grey":
      return Colors.grey;
    case "brown":
      return Colors.brown;
    default:
      return Colors.grey.shade400; // fallback
  }
}
