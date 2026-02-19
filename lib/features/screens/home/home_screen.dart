
import 'package:ecommerceapp/features/screens/home/product_list/product_list_screen.dart';
import 'package:ecommerceapp/features/screens/home/slider/home_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'categories/bloc/category_bloc.dart';
import 'categories/bloc/category_state.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onSeeAllCategories;
  const HomeScreen({super.key, this.onSeeAllCategories});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // 🔹 Left padding + bigger logo
        leadingWidth: 120, // 👈 space control
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(
            'assets/images/logo_nav.png',
            height: 42, // 👈 logo size
            fit: BoxFit.contain,
          ),
        ),

        // 🔹 Right padding + gray icons
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                context.push('/profile');
              },
              icon: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0), // 🔘 light gray bg
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F0F0), // 🔘 light gray bg
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_outlined,
                color: Colors.grey,
                size: 22,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              onPressed: () {},
              icon: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0F0F0), // 🔘 light gray bg
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notification_add_outlined,
                  color: Colors.grey,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey[500]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Banner Carousel
              BannerCarousel(),
              const SizedBox(height: 24),

              // All Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'All Categories',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    TextButton(
                      onPressed: widget.onSeeAllCategories,
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF00BFA5),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is CategoryLoaded) {
                    final top10 = state.categories.take(10).toList();

                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: top10.length,
                        itemBuilder: (context, index) {
                          final cat = top10[index];

                          return Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductListScreen(
                                      categoryId: cat.id,
                                      categoryName: cat.title,
                                    ),
                                  ),
                                );
                                print('Tapped on category: ${cat.title}');
                                print('ID: ${cat.id}');
                              },
                              child: Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE0F7F4),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Image.network(
                                        cat.icon,
                                        width: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      (cat.title ?? "").length > 7
                                          ? "${cat.title!.substring(0, 7)}..."
                                          : (cat.title ?? ""),
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF00BFA5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  return SizedBox();
                },
              ),

              // Category Icons
              const SizedBox(height: 24),

              // Popular Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: Color(0xFF00BFA5),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Product Grid
              SizedBox(
                height: 240,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildProductCard();
                  },
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F7F4),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 40, color: const Color(0xFF00BFA5)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF00BFA5),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard() {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F7F4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/shoe.png',
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.shopping_bag,
                        size: 60,
                        color: Color(0xFF00BFA5),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF00BFA5),
                      shape: BoxShape.circle,
                    ),
                    child: const IconButton(
                      icon: Icon(Icons.favorite_border, size: 20),
                      color: Colors.white,
                      onPressed: null,
                      padding: EdgeInsets.all(6),
                      constraints: BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'New Year Special Shoe 30',
            style: TextStyle(fontSize: 13, color: Colors.grey),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text(
                '\$100',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00BFA5),
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                '4.8',
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
