import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';

import '../../models/module.dart';
import '../../network/buro_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BuroRepository repository;

  HomeCubit(this.repository) : super(HomeInitialState());

  Future<Module?> getHomeData() async {
    emit(HomeInitialState());
    try {
      emit(HomeLoadingState());
      var response = await repository.getModule();
      emit(HomeLoadedState(response!));
      return response;
    } catch (e) {
      print('Home ModuleErrorState ${e.toString()}');
      emit(HomeErrorState(e));
    }
  }
}
