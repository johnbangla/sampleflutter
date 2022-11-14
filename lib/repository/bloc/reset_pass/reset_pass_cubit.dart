import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/change_pass_model.dart';
import '../../network/buro_repository.dart';

part 'reset_pass_state.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  final BuroRepository repository;
  ResetPassCubit(this.repository) : super(ResetPassInitialState());

  Future<ChangePasswordModel?> resetPass(
      String oldPass, String newPass, String confirmPass) async {
    print('Submit Change pass called');

    emit(ResetPassInitialState());
    try {
      emit(ResetPassLoadingState());
      var response =
          await repository.resetPassword(oldPass, newPass, confirmPass);
      emit(ResetPassLoadedState(response));
      return response;
    } catch (e) {
      print('Home ModuleErrorState ${e.toString()}');
      emit(ResetPassErrorState(e));
    }
  }

  void initState() {
    emit(ResetPassInitialState());
  }

//ResetPassCubit() : super(ResetPassInitialState());
}
