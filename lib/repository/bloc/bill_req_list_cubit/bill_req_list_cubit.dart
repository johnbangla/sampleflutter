import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/bill_download_info.dart';
import '../../models/bill_request.dart';
import '../../network/buro_repository.dart';

part 'bill_req_list_state.dart';

class BillReqListCubit extends Cubit<BillReqListState> {
  BuroRepository buroRepository;

  BillReqListCubit(this.buroRepository) : super(BillReqListInitialState());

  Future<BillRequest?> getBillReqList() async {
    emit(BillReqListInitialState());

    try {
      emit(BillReqListLoadingState());
      var response = await buroRepository.getBillRequest();
      emit(BillReqListLoadedState(response));
      return response;
    } catch (e) {
      emit(BillReqListErrorState(e));
    }
  }

  Future<BillDownloadInfo?> getBillDownloadInfo(int applicationId) async {
    // emit(BillReqListInitialState());

    try {
      //emit(BillReqListLoadingState());
      var response = await buroRepository.getBillDownloadInfo(applicationId);
      //emit(BillDownloadLoadedState(response!));
      print('Response $response');
      return response;
    } catch (e) {
      print('Error  ${e.toString()} '); //emit(BillReqListErrorState(e));

    }
  }
}
