import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/bill_request_details.dart';
import '../../models/bill_submit_model.dart';
import '../../network/buro_repository.dart';

part 'bill_details_state.dart';

class BillDetailsCubit extends Cubit<BillDetailsState> {
  final BuroRepository repository;
  BillDetailsCubit(this.repository) : super(BillDetailsInitialState());

  Future<BillRequestDetails?> getBillDetails(int applicationId) async {
    emit(BillDetailsInitialState());

    try {
      emit(BillDetailsLoadingState());
      var response = await repository.getBillRequestDetails(applicationId);
      emit(BillDetailsLoadedState(response));
      return response;
    } catch (e) {
      emit(BillDetailsErrorState(e));
    }
  }

  Future<BillSubmitModel?> billSubmit(List submitList) async {
    emit(BillDetailsInitialState());

    try {
      emit(BillDetailsLoadingState());
      var response = await repository.billSubmit(submitList);
      emit(BillSubmitLoadedState(response));
      return response;
    } catch (e) {
      emit(BillDetailsErrorState(e));
    }
  }

  void initState() {
    emit(BillDetailsInitialState());
  }
}
