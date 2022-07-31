import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wieght_tracker_app/data/models/weight_model.dart';
import 'package:wieght_tracker_app/data/services/firestore.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  List<WeightModel> weights = [];

  Future<void> addWeight(WeightModel weightModel) async {
    emit(HomeLoading());
    try {
      await Firestore.storeWeight(weightModel);
      emit(HomeSuccess());
    } catch (e) {
      debugPrint('something Wrong');
      emit(HomeFailed());
    }
  }

  Future<List<WeightModel>> getWeights() async {
    emit(HomeLoading());
    try {
      weights = [];
      weights = await Firestore.getListOfWeights();
      emit(HomeSuccess());
    } catch (e) {
      debugPrint('something wrong');
      emit(HomeFailed());
    }
    return weights;
  }

  Future<void> updateWeight(WeightModel weightModel) async {
    emit(HomeLoading());
    try {
      await Firestore.updateWeight(weightModel);
      emit(HomeSuccess());
    } catch (e) {
      debugPrint('something wrong');
      emit(HomeFailed());
    }
  }

  Future<void> deleteWeight(WeightModel weightModel) async {
    emit(HomeLoading());
    try {
      await Firestore.deleteWeight(weightModel);
      emit(HomeSuccess());
    } catch (e) {
      debugPrint('something wrong');
      emit(HomeFailed());
    }
  }
}
