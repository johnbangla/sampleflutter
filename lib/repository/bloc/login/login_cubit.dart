import 'package:bloc/bloc.dart';

import '../../models/login_user.dart';
import '../../models/user_authenticate.dart';
import '../../network/buro_repository.dart';

class LoginCubit extends Cubit<LoginUser?> {
  BuroRepository buroRepository;

  LoginCubit({required this.buroRepository}) : super(null);

  Future<UserAthenticate> getToken(String username, String password) async {
    var response = await this.buroRepository.getToken(username, password);

    return response;
  }

  Future<LoginUser> authenticateWithToken(String token) async {
    var response = await this.buroRepository.authenticateWithToken(token);

    emit(response);

    return response;
  }

  // Future<LoginUser> authenticate(String username, String password) async {
  //   print("Authenticate Called");

  //   var response = await this.buroRepository.authenticate(username, password);

  //   emit(response);

  //   return response;
  // }
}
