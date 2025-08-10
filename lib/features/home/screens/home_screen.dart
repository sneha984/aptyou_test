// import 'package:aptyou_test/core/commons/constants/image_constants.dart';
// import 'package:aptyou_test/theme/palette.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../core/commons/global_variables/global_variables.dart';
// import '../controller/home_controller.dart';
//
// class HomePage extends ConsumerStatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   ConsumerState<HomePage> createState() => _ReviewScreenState();
// }
//
// class _ReviewScreenState extends ConsumerState<HomePage>
//     with TickerProviderStateMixin {
//   late AnimationController _scaleController;
//   late Animation<double> _scaleAnimation;
//   late AnimationController _starController;
//   late Animation<double> _starAnimation;
//   final highlighterProvider = StateProvider<bool>((ref) => false);
//
//   @override
//   void initState() {
//     super.initState();
//
//     _scaleController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
//       CurvedAnimation(
//         parent: _scaleController,
//         curve: Curves.easeInOut,
//       ),
//     );
//
//     _starController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     );
//
//     _starAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
//       CurvedAnimation(parent: _starController, curve: Curves.elasticOut),
//     );
//   }
//
//   bool showLottieStar = false;
//   int previousScore = 0;
//
//   @override
//   void dispose() {
//     _scaleController.dispose();
//     _starController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(reviewControllerProvider);
//     final controller = ref.read(reviewControllerProvider.notifier);
//
//     if (state.score > previousScore) {
//       previousScore = state.score;
//       setState(() => showLottieStar = true);
//
//       Future.delayed(const Duration(seconds: 1), () {
//         if (mounted) {
//           setState(() => showLottieStar = false);
//         }
//       });
//     }
//
//     if (state.loading) {
//       return Scaffold(
//         backgroundColor: Palette.primaryColor,
//         body: const Center(
//           child: CircularProgressIndicator(color: Palette.whiteColor),
//         ),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: Palette.whiteColor,
//       body: Column(
//         children: [
//           ClipPath(
//             clipper: BottomCurveClipper(),
//             child: Container(
//               width: double.infinity,
//               color: Palette.primaryColor,
//               padding: EdgeInsets.symmetric(
//                 horizontal: width * 0.03,
//                 vertical: height * 0.06,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: CircleAvatar(
//                           backgroundColor: Colors.white24,
//                           child: Icon(Icons.arrow_back_ios_new,
//                               size: height * 0.02, color: Palette.whiteColor),
//                         ),
//                       ),
//                       SizedBox(width: width * 0.02),
//                       Text(
//                         'Review',
//                         style: GoogleFonts.fredoka(
//                           color: Palette.whiteColor,
//                           fontSize: height * 0.03,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: height * 0.03),
//                   Padding(
//                     padding: EdgeInsets.only(left: width * 0.03),
//                     child: Text(
//                       "Activity Progress: Round ${state.round}",
//                       style: GoogleFonts.fredoka(
//                         color: Colors.white70,
//                         fontSize: height * 0.018,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: height * 0.01),
//                   Padding(
//                     padding: EdgeInsets.only(left: width * 0.02),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(width * 0.02),
//                             child: LinearProgressIndicator(
//                               value: (state.round - 1) / 10,
//                               backgroundColor: Colors.white24,
//                               valueColor: const AlwaysStoppedAnimation<Color>(
//                                   Palette.whiteColor),
//                               minHeight: 8,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: width * 0.02),
//                         SizedBox(
//                           width: width * 0.08,
//                           height: height * 0.05,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               if (showLottieStar)
//                                 Lottie.asset(
//                                   height: height * 0.06,
//                                   width: width * 0.3,
//                                   Constants.starLottie,
//                                   repeat: false,
//                                 ),
//                               ScaleTransition(
//                                 scale: _starAnimation,
//                                 child: Icon(Icons.star,
//                                     color: Colors.yellowAccent,
//                                     size: height * 0.024),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(width: width * 0.01),
//                         Text("${state.score}/10",
//                             style:
//                                 GoogleFonts.fredoka(color: Palette.whiteColor)),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: height * 0.03),
//                   Center(
//                     child: Column(
//                       children: [
//                         Text(
//                           "Tap the letters you hear",
//                           style: GoogleFonts.fredoka(
//                             color: Palette.whiteColor,
//                             fontSize: height * 0.027,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         SizedBox(height: height * 0.015),
//                         Text(
//                           state.promptText,
//                           style: GoogleFonts.fredoka(
//                             color: Colors.white70,
//                             fontSize: height * 0.02,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: height * 0.01),
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.all(height * 0.02),
//               child: AnimatedSwitcher(
//                 duration: const Duration(seconds: 1),
//                 transitionBuilder: (child, animation) {
//                   return FadeTransition(
//                     opacity: animation,
//                     child: ScaleTransition(scale: animation, child: child),
//                   );
//                 },
//                 child: GridView.count(
//                   key: ValueKey(state.currentLetters.join()),
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 20,
//                   mainAxisSpacing: 20,
//                   childAspectRatio: 1,
//                   children: List.generate(state.currentLetters.length, (index) {
//                     final letter = state.currentLetters[index];
//
//                     return AnimatedBuilder(
//                       animation: _scaleController,
//                       builder: (context, child) {
//                         final scale = ref.watch(highlighterProvider) == true &&
//                                 state.targetLetter == letter
//                             ? _scaleAnimation.value
//                             : 1.0;
//                         return Transform.scale(scale: scale, child: child);
//                       },
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                               color: const Color(0xfff9ebe8), width: 9),
//                           borderRadius: BorderRadius.circular(16),
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Color(0xfff9ebe8),
//                               blurRadius: 12,
//                               spreadRadius: 1,
//                               offset: Offset(0, 6),
//                             ),
//                           ],
//                           color: ref.watch(highlighterProvider) == true &&
//                                   state.targetLetter == letter
//                               ? Colors.yellowAccent
//                               : Colors.white,
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (state.targetLetter !=
//                                 state.currentLetters[index]) {
//                               ref.read(highlighterProvider.notifier).state =
//                                   true;
//
//                               Future.delayed(const Duration(seconds: 2), () {
//                                 ref.read(highlighterProvider.notifier).state =
//                                     false;
//                               });
//                             }
//                             // _triggerHighlightAnimation(index);
//                             controller.tapLetter(letter, context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.transparent,
//                             shadowColor: Colors.transparent,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: Text(
//                             letter,
//                             style: GoogleFonts.fredoka(
//                               fontSize: height * 0.03,
//                               fontWeight: FontWeight.w500,
//                               color: ref.watch(highlighterProvider) == true &&
//                                       state.targetLetter == letter
//                                   ? Palette.blackColor
//                                   : Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class BottomCurveClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 40);
//     path.quadraticBezierTo(
//         size.width / 2, size.height + 40, size.width, size.height - 40);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
