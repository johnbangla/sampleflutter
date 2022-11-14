import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/change_pass_model.dart';
import '../../network/buro_repository.dart';

part 'change_pass_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final BuroRepository repository;
  ChangePasswordCubit(this.repository) : super(ChangePasswordInitialState());

  Future<ChangePasswordModel?> submitChangePass(bool isForgetPass,
      String oldPass, String newPass, String confirmPass) async {
    print('Submit Change pass called');

    emit(ChangePasswordInitialState());
    //try {
    emit(ChangePasswordLoadingState());
    var response = await repository.changePassword(
        isForgetPass, oldPass, newPass, confirmPass);
    emit(ChangePasswordLoadedState(response));
    return response;

    /*  } catch (e) {
      print('Home ModuleErrorState ${e.toString()}');
      emit(ChangePasswordErrorState(e));
    }*/
  }

  /*void initState(){
    emit(ChangePasswordInitialState());
  }*/

}
