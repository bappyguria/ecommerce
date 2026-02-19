abstract class PinVerificationState {}

class PinVerificationInitial extends PinVerificationState {}

class PinVerificationLoading extends PinVerificationState {}
class PinVerificationSuccess extends PinVerificationState {
  String message;
  PinVerificationSuccess(this.message);
}

class PinVerificationError extends PinVerificationState {
  final String message;
  PinVerificationError(this.message);
}
