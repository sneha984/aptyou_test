import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  final BuildContext context;

  final VoidCallback onSuccess;

  const SignInRequested(this.context, this.onSuccess);

  @override
  List<Object?> get props => [context];
}
