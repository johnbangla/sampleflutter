import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/my_plan.dart';
import '../../models/request_cancel.dart';
import '../../network/buro_repository.dart';

part 'plan_list_state.dart';

class PlanListCubit extends Cubit<PlanListState> {
  BuroRepository repository;

  PlanListCubit(this.repository) : super(PlanListInitialState());
  Future<MyPlan?> getPlanList() async {
    emit(PlanListInitialState());

    try {
      emit(PlanListLoadingState());
      var response = await repository.getMyPlan();
      emit(PlanListLoadedState(response));
      return response;
    } catch (e) {
      emit(PlanListErrorState(e));
    }
  }

  Future<RequestCancel?> cancelPlanRequestAll(int planId) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.cancelPlanRequestAll(planId);
      //emit(CancelAllLoadedState(response));
      return response;
    } catch (e) {
      //emit(RequestErrorState(e));
    }
  }
}
