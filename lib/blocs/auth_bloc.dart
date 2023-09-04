import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent)  {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: event.email, password: event.password);
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'user-not-found') {
            emit(LoginFailure(errMessage: 'User not found'));
          } else if (ex.code == 'wrong-password') {
            emit(LoginFailure(errMessage: 'Wrong password'));
          }
        } catch (e) {
          emit(LoginFailure(errMessage: 'Something went wrong'));
        }
      } else if (event is RegisterEvent){
        emit(RegisterLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == 'weak-password') {
            emit(RegisterFailure(errMessage: 'Weak password'));
          } else if (ex.code == 'email-already-in-use') {
            emit(RegisterFailure(errMessage: 'This E-mail already exists'));
          }
        } catch (e) {
          emit(RegisterFailure(errMessage: 'Something went wrong'));
        }
      }
    });
  }
}
