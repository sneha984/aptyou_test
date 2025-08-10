import 'package:aptyou_test/core/commons/global_variables/global_variables.dart';
import 'package:aptyou_test/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/commons/constants/image_constants.dart';
import '../../review/screen/review_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF8C7A),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            // Already handled by SnackBar in BLoC, optional extra UI
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Firebase Sign In",
                  style: GoogleFonts.fredoka(
                    color: Palette.whiteColor,
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  "Login Below With Anyone of the Method's",
                  style: GoogleFonts.fredoka(
                    color: Colors.white70,
                    fontSize: height * 0.02,
                  ),
                ),
                SizedBox(height: height * 0.08),
                state is AuthLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.07,
                              vertical: height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: Image.asset(
                          Constants.google,
                          height: height * 0.04,
                        ),
                        label: Text(
                          "Sign in With Google",
                          style: GoogleFonts.fredoka(
                              color: Colors.black87,
                              fontSize: height * 0.02,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                SignInRequested(context, () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HomePage()),
                                  );
                                }),
                              );
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
