import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/approval_action.dart';
import '../../models/approval_request_details.dart';
import '../../network/buro_repository.dart';

part 'approval_details_state.dart';

class ApprovalDetailsCubit extends Cubit<ApprovalDetailsState> {
  BuroRepository repository;

  //RequestCubit(this.repository) : super(RequestInitialState());

  ApprovalDetailsCubit(this.repository) : super(ApprovalDetailsInitialState());

  Future<ApprovalRequestDetails?> getApprovalDetails(int applicationId) async {
    emit(ApprovalDetailsInitialState());

    try {
      emit(ApprovalDetailsLoadingState());
      var response = await repository.getApprovalDetails(applicationId);
      emit(ApprovalDetailsLoadedState(response));
      return response;
    } catch (e) {
      emit(ApprovalDetailsErrorState(e));
    }
  }

  Future<ApprovalAction?> approvalAction(
      int appDetailsId, int applicationId, String actionType) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.approvalAction(
          appDetailsId, applicationId, actionType);
      //emit(RequestCancelLoadedState(response));
      return response;
    } catch (e) {
      //emit(RequestDetailsErrorState(e));
    }
  }
}
