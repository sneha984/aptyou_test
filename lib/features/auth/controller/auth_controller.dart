import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return AuthController(repository);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Dio());
});

class AuthController {
  final AuthRepository _repository;

  AuthController(this._repository);

  Future<void> signInWithFirebase(
      BuildContext context, VoidCallback onSuccess) async {
    try {
      final token = await _repository.signInWithFirebase();

      if (token != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful!')),
        );
        onSuccess();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed - No Token Found!')),
        );
      }
    } catch (e) {
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login Failed!')),
      );
    }
  }
}
