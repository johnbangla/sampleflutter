import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/approval_action.dart';
import '../../models/plan_approval_request.dart';
import '../../network/buro_repository.dart';

part 'plan_approval_state.dart';

class PlanApprovalCubit extends Cubit<PlanApprovalState> {
  BuroRepository repository;

  //RequestCubit(this.repository) : super(RequestInitialState());

  PlanApprovalCubit(this.repository) : super(PlanApprovalInitialState());

  Future<PlanApprovalRequest?> getPlanApprovalList() async {
    emit(PlanApprovalInitialState());
    try {
      emit(PlanApprovalLoadingState());
      var response = await repository.getPlanApproval();
      emit(PlanApprovalLoadedState(response));
      return response;
    } catch (e) {
      emit(PlanApprovalErrorState(e));
    }
  }

  Future<ApprovalAction?> planApprovalActionAll(
      int planId, String actionType) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.planApprovalActionAll(planId, actionType);
      //emit(CancelAllLoadedState(response));
      return response;
    } catch (e) {
      //emit(RequestErrorState(e));
    }
  }
}
