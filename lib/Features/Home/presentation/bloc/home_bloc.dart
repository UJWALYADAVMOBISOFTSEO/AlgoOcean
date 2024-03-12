import 'dart:async';

import 'package:algoocean/Features/Home/data/api_services/repository.dart';
import 'package:algoocean/Features/Home/data/model/HomeModal.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeData>(_getHomeData);
  }

  final HomeRepository _apiRepository = HomeRepository();

  //HOME BLOCK
  Future<void> _getHomeData(HomeData event, Emitter<HomeState> emit) async {
    try {
      emit(const HomeLoading());
      final mList = await _apiRepository.getHomeData();
      debugPrint('Home Data $mList');
      emit(HomeSuccess(homeModal: mList));
    } catch (error, stacktrace) {
      debugPrint("Exception occured: $error stackTrace: $stacktrace");
      throw " error Occurred in Home Bloc";
    }
  }
}
