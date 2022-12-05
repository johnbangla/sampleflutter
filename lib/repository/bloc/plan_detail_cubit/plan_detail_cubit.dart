import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/plan_detail_model.dart';
import '../../models/request_cancel.dart';
import '../../network/buro_repository.dart';

part 'plan_detail_state.dart';

class PlanDetailCubit extends Cubit<PlanDetailState> {



  BuroRepository repository;

  PlanDetailCubit(this.repository) : super(PlanDetailInitialState());

  Future<PlanDetailModel?> getPlanDetails(int planId) async {
    emit(PlanDetailInitialState());

    try {
      emit(PlanDetailInitialState());
      var response = await repository.getPlanDetails(planId);
      emit(PlanDetailLoadedState(response));
      return response;
    } catch (e) {
      emit(PlanDetailErrorState(e));
    }
  }




  Future<RequestCancel?> cancelPlanRequestIndividual(int planDetailsId) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.cancelPlanRequestIndividual(planDetailsId);
      //emit(RequestCancelLoadedState(response));
      return response;


    } catch (e) {
      //emit(RequestDetailsErrorState(e));
    }
  }




}
