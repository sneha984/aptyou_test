// import 'package:aptyou_test/core/commons/global_variables/global_variables.dart';
// import 'package:aptyou_test/theme/palette.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../core/commons/constants/image_constants.dart';
// import '../../home/screens/home_screen.dart';
// import '../controller/auth_controller.dart';
//
// class LoginScreen extends ConsumerWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authController = ref.read(authControllerProvider);
//
//     return Scaffold(
//       backgroundColor: Color(0xFFFF8C7A),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Firebase Sign In",
//               style: GoogleFonts.fredoka(
//                 color: Palette.whiteColor,
//                 fontSize: height * 0.04,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: height * 0.01),
//             Text(
//               "Login Below With Anyone of the Method's",
//               style: GoogleFonts.fredoka(
//                 color: Colors.white70,
//                 fontSize: height * 0.02,
//               ),
//             ),
//             SizedBox(height: height * 0.08),
//             ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white,
//                 padding: EdgeInsets.symmetric(
//                     horizontal: width * 0.07, vertical: height * 0.02),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//               ),
//               icon: Image.asset(
//                 Constants.google,
//                 height: height * 0.04,
//               ),
//               label: Text(
//                 "Sign in With Google",
//                 style: GoogleFonts.fredoka(
//                     color: Colors.black87,
//                     fontSize: height * 0.02,
//                     fontWeight: FontWeight.w500),
//               ),
//               onPressed: () {
//                 authController.signInWithFirebase(context, () {
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (_) => HomePage()),
//                   );
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
