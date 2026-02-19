import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/network/api_client.dart';
import 'slider_event.dart';
import 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  SliderBloc() : super(SliderInitial()) {
    on<LoadSliderEvent>((event, emit) async {
      emit(SliderLoading());
      try {
        final response = await ApiService.fetchHomeSliderImages();
        emit(SliderLoaded(response));
      } catch (e) {
        emit(SliderError(e.toString()));
      }
    });
  }
}
