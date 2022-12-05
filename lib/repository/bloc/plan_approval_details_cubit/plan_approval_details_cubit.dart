import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/approval_action.dart';
import '../../models/plan_approval_details_model.dart';
import '../../network/buro_repository.dart';

part 'plan_approval_details_state.dart';

class PlanApprovalDetailsCubit extends Cubit<PlanApprovalDetailsState> {
  BuroRepository repository;

  PlanApprovalDetailsCubit(this.repository)
      : super(PlanApprovalDetailsInitialState());

  Future<PlanApprovalDetailsModel?> getPlanApprovalDetails(int planId) async {
    emit(PlanApprovalDetailsInitialState());

    try {
      emit(PlanApprovalDetailsInitialState());
      var response = await repository.getPlanApprovalDetails(planId);
      emit(PlanApprovalDetailsLoadedState(response));
      return response;
    } catch (e) {
      emit(PlanApprovalDetailsErrorState(e));
    }
  }

  Future<ApprovalAction?> planApproveAction(
      int planDetailsID, int planID, String actionType) async {
    // emit(PlanApprovalActionInitialState());
    try {
      //emit(PlanApprovalActionLoadingState());
      var response = await repository.planApprovalActionIndividual(
          planDetailsID, planID, actionType);
      //emit(PlanApprovalActionLoadedState(response));
      return response;
    } catch (e) {
      //emit(PlanApprovalActionErrorState());
    }
  }
}
