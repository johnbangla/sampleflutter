import 'package:equatable/equatable.dart';

import '../../models/verify_otp.dart';

abstract class VerifyOtpState extends Equatable {}

class InitialState extends VerifyOtpState {
  @override
  List<Object?> get props => [];
  //print();
}

class LoadingState extends VerifyOtpState {
  @override
  List<Object?> get props => [];
}

class LoadedState extends VerifyOtpState {
  LoadedState(this.verifyOtp);

  final VerifyOtp verifyOtp;

  @override
  List<Object> get props => [];

  VerifyOtp get result => verifyOtp;
}

class ErrorState extends VerifyOtpState {
  @override
  List<Object?> get props => [];
}
