abstract class PinVerificationEvent {}

class SubmitPinVerification extends PinVerificationEvent {
  final String email;
  final String pinCode;


  SubmitPinVerification({
    required this.email,
    required this.pinCode,
  });
}
