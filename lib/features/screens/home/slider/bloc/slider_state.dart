abstract class SliderState {}

class SliderInitial extends SliderState {}

class SliderLoading extends SliderState {}

class SliderLoaded extends SliderState {
  final List<String> images;
  SliderLoaded(this.images);
}

class SliderError extends SliderState {
  final String message;
  SliderError(this.message);
}
