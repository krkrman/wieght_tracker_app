import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wieght_tracker_app/data/services/firebase_authentication.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  void authenticateAnonymously() async {
    FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();
    emit(AuthLoading());
    try {
      await firebaseAuthentication.authenticateAnonymously();
      emit(AuthSuccess());
    }catch(e){
      emit(AuthFailed());
    }
  }
}
