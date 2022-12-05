import 'package:bloc/bloc.dart';

import '../../models/generate_otp.dart';
import '../../network/buro_repository.dart';

class GenerateOtpCubit extends Cubit<GenerateOTP?> {
  BuroRepository buroRepository;

  //LoginCubit({required this.buroRepository}) : super(null);

  GenerateOtpCubit({required this.buroRepository}) : super(null);

  Future<GenerateOTP> getOtp(String userId) async {
    //print("Authenticate Called");

    var response = await buroRepository.getOtp(userId);

    emit(response);

    return response;
  }
}
