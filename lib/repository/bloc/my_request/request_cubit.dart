import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/my_request.dart';
import '../../models/request_cancel_all.dart';
import '../../network/buro_repository.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {

   BuroRepository repository;

  RequestCubit(this.repository) : super(RequestInitialState());
  Future<MyRequest?> getRequestList() async {
    emit(RequestInitialState());


    try {
      emit(RequestLoadingState());
      var response = await repository.getRequestList();
      emit(RequestLoadedState(response));
      return response;


    } catch (e) {
      emit(RequestErrorState(e));
    }
  }


  Future<RequestCancelAll?> requestCancelAll(int applicationId) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.cancelAllRequest(applicationId);
      //emit(CancelAllLoadedState(response));
      return response;


    } catch (e) {
      //emit(RequestErrorState(e));
    }
  }

}
