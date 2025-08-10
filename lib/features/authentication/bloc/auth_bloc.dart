import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final token = await repository.signInWithFirebase();

      if (token != null) {
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text('Login Successful!')),
        );
        emit(AuthSuccess());
        event.onSuccess();
      } else {
        ScaffoldMessenger.of(event.context).showSnackBar(
          SnackBar(content: Text('Login Failed - No Token Found!')),
        );
        emit(AuthFailure('No token found'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
      ScaffoldMessenger.of(event.context).showSnackBar(
        SnackBar(content: Text('Login Failed!')),
      );
    }
  }
}
