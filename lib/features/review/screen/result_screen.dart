import 'package:aptyou_test/theme/palette.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../core/commons/constants/image_constants.dart';
import '../../../core/commons/global_variables/global_variables.dart';

class ResultScreen extends StatefulWidget {
  final int score;
  final int total;
  final List<String> finishAudios;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.total,
    required this.finishAudios,
  }) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // From bottom
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _visible = true;
      });
      _controller.forward();
    });

    playFinishAudio();
  }

  Future<void> playFinishAudio() async {
    if (widget.finishAudios.isEmpty) return;

    await _audioPlayer.play(UrlSource(widget.finishAudios[0]));
    await _audioPlayer.onPlayerComplete.first;

    if (widget.score >= 8 && widget.finishAudios.length > 1) {
      await _audioPlayer.play(UrlSource(widget.finishAudios[1]));
    } else if (widget.finishAudios.length > 2) {
      await _audioPlayer.play(UrlSource(widget.finishAudios[2]));
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double percent = (widget.score / widget.total) * 100;
    final bool passed = widget.score >= 8;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Palette.primaryColor.withOpacity(0.8),
              Palette.primaryColor.withOpacity(0.4)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: AnimatedOpacity(
                    curve: Curves.bounceOut,
                    duration: const Duration(milliseconds: 800),
                    opacity: _visible ? 1.0 : 0.0,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                          top: -60,
                          child: SizedBox(
                            height: height * 0.8,
                            width: width,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Lottie.asset(
                                  Constants.popper1Lottie,
                                  repeat: true,
                                  fit: BoxFit.cover,
                                ),
                                Lottie.asset(
                                  Constants.popper2Lottie,
                                  repeat: true,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.02),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(height: height * 0.09),
                              Text(
                                "You did amazing,\nLetter Detective!",
                                style: GoogleFonts.fredoka(
                                  fontSize: height * 0.045,
                                  fontWeight: FontWeight.w600,
                                  color: Palette.whiteColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: height * 0.12),
                              Text(
                                "Your Score",
                                style: GoogleFonts.fredoka(
                                  fontSize: height * 0.03,
                                  color: Palette.whiteColor,
                                ),
                              ),
                              Text(
                                "${widget.score}/${widget.total}",
                                style: GoogleFonts.fredoka(
                                  fontSize: height * 0.08,
                                  fontWeight: FontWeight.bold,
                                  color: Palette.whiteColor,
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                "${percent.toInt()}%",
                                style: GoogleFonts.fredoka(
                                  fontSize: height * 0.05,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: height * 0.06),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(width * 0.07),
            child: InkWell(
              onTap: () {
                // if (passed) {
                //   // Navigator.push(context,
                //   //     MaterialPageRoute(builder: (context) => SplashScreen()));
                //   Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => SplashScreen()),
                //     (Route<dynamic> route) => false,
                //   );
                // } else {
                //   //
                //
                //   Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => SplashScreen()),
                //     (Route<dynamic> route) => false,
                //   );
                // }
              },
              borderRadius: BorderRadius.circular(width * 0.07),
              child: Container(
                width: width * 0.8,
                height: height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(width * 0.07),
                ),
                alignment: Alignment.center,
                child: Text(
                  passed ? "Next" : "Try Again",
                  style: GoogleFonts.fredoka(
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Palette.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
