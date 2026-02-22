import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../product_list/product_list_screen.dart';
import 'bloc/category_bloc.dart';
import 'bloc/category_event.dart';
import 'bloc/category_state.dart';

class CategoriesListScreen extends StatefulWidget {
  const CategoriesListScreen({super.key});

  @override
  State<CategoriesListScreen> createState() => _CategoriesListScreenState();
}

class _CategoriesListScreenState extends State<CategoriesListScreen> {
  final ScrollController _scrollController = ScrollController();

  double oldMaxScroll = 0;

  @override
  void initState() {
    super.initState();

    final bloc = context.read<CategoryBloc>();

    bloc.add(ResetCategories()); // 🔥 reset first
    bloc.add(LoadCategories()); // 🔥 load from page 1

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 150) {
        if (bloc.hasMore && !bloc.isLoadingMore) {
          bloc.add(LoadMoreCategories());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          /// 🔹 First Loading
          if (state is CategoryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          /// 🔹 Loaded
          if (state is CategoryLoaded) {
            final items = state.categories;
           
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.9,
                        ),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return InkWell(
                        onTap: () {
                          context.push('/product-list/${item.id}/${item.title}');
                          print('Tapped on category: ${item.title}');
                          print('ID: ${item.id}');
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(.12),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F7F4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: _buildImage(item.icon),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF00BFA5),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// 🔹 Bottom Loading Bar
                if (state.isLoadingMore)
                  const LinearProgressIndicator(minHeight: 3),
              ],
            );
          }

          /// 🔹 Error
          if (state is CategoryError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildImage(String url) {
    if (url.isEmpty) {
      return const Icon(Icons.image, size: 40);
    }

    return Image.network(
      url,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported),
    );
  }
}
