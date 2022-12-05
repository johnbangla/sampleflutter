import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/verify_otp.dart';
import '../../network/buro_repository.dart';

part 'forgot_pass_verification_state.dart';

// class ForgotPassVerificationCubit extends Cubit<ForgotPassVerificationState> {
//   BuroRepository buroRepository;

//   ForgotPassVerificationCubit({required this.buroRepository})
//       : super(ForgotPassVerificationInitialState());

//   Future<VerifyOtp?> verifyOtpResetPass(
//       {required String mobileOtp, required String emailOtp}) async {
//     emit(ForgotPassVerificationInitialState());

//     try {
//       emit(ForgotPassVerificationLoadingState());
//       var response =
//           await buroRepository.verifyOtpResetPass(mobileOtp, emailOtp);
//       emit(ForgotPassVerificationLoadedState(response));
//       return response;
//     } catch (e) {
//       emit(ForgotPassVerificationErrorState(e));
//     }
//   }
// }
class ForgotPassVerificationCubit extends Cubit<ForgotPassVerificationState> {
  BuroRepository buroRepository;

  ForgotPassVerificationCubit({required this.buroRepository})
      : super(ForgotPassVerificationInitialState());

  Future<VerifyOtp?> submitOtpForgotPass(
      {required String mobileOtp, required String emailOtp}) async {
    emit(ForgotPassVerificationInitialState());

    try {
      emit(ForgotPassVerificationLoadingState());
      var response =
          await buroRepository.submitOtpForgotPass(mobileOtp, emailOtp);
      emit(ForgotPassVerificationLoadedState(response));
      return response;
    } catch (e) {
      emit(ForgotPassVerificationErrorState(e));
    }
  }
}
