
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../data/models/category_model.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  List<CategoryModel> categories = [];
  int currentPage = 1;
  bool hasMore = true;
  bool isLoadingMore = false; // 🔥 ADD THIS
  final int limit = 20;

  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());

      try {
        final res = await ApiService.getCategories(
          limit: limit,
          page: currentPage,
        );

        categories = res['items'];
        currentPage++;

        if (categories.length >= res['total']) {
          hasMore = false;
        }

        emit(CategoryLoaded(categories, hasMore, isLoadingMore: false));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });

    on<LoadMoreCategories>((event, emit) async {
      if (!hasMore || isLoadingMore) return; // 🔥 FIX

      isLoadingMore = true;
      emit(CategoryLoaded(categories, hasMore, isLoadingMore: true));

      try {
        final res = await ApiService.getCategories(
          limit: limit,
          page: currentPage,
        );

        categories.addAll(res['items']);
        currentPage++;

        if (categories.length >= res['total']) {
          hasMore = false;
        }

        emit(CategoryLoaded(categories, hasMore, isLoadingMore: false));
      } catch (_) {
        emit(CategoryLoaded(categories, hasMore, isLoadingMore: false));
      }

      isLoadingMore = false;
    });
    on<ResetCategories>((event, emit) {
      categories.clear();
      currentPage = 1;
      hasMore = true;
      isLoadingMore = false;
    });
  }
}
