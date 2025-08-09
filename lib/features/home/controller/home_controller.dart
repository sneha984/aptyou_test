import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/review_state.dart';
import '../repository/home_repository.dart';
import '../screens/result_screen.dart';

final reviewControllerProvider =
    StateNotifierProvider.autoDispose<ReviewController, ReviewState>((ref) {
  final repository = ReviewRepository(Dio());
  final controller = ReviewController(repository);

  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});

class ReviewController extends StateNotifier<ReviewState> {
  final ReviewRepository repository;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> allLetters = [
    'S',
    's',
    'A',
    'a',
    'T',
    't',
    'P',
    'p',
    'N',
    'n',
    'I',
    'i'
  ];

  ReviewController(this.repository) : super(ReviewState()) {
    _loadAssets();
  }

  void setHighlight(int index) {
    state = state.copyWith(highlightIndex: index);
  }

  void clearHighlight() {
    state = state.copyWith(highlightIndex: -1);
  }

  Future<void> _loadAssets() async {
    final assets = await repository.fetchSampleAssets();
    if (assets == null) return;

    final prompt = _getNewTarget(1);
    final target = _extractLetterFromPrompt(prompt);
    final letters = _getShuffledLetters(target);

    state = state.copyWith(
      loading: false,
      sampleAssets: assets,
      promptText: prompt,
      targetLetter: target,
      currentLetters: letters,
    );

    await _audioPlayer.play(UrlSource(assets.introAudio));
    await _audioPlayer.onPlayerComplete.first;
    await _playLetterAudio();
  }

  String _getNewTarget(int round) {
    List<String> prompts = [
      'Find Big S',
      'Find Small a',
      'Find Big T',
      'Find Small s',
      'Find Big A',
      'Find Small t',
      'Find Small a',
      'Find Big T',
      'Find Small s',
      'Find Big A'
    ];
    return prompts[(round - 1) % prompts.length];
  }

  String _extractLetterFromPrompt(String prompt) => prompt.split(' ').last;

  List<String> _getShuffledLetters(String targetLetter) {
    final distractors = allLetters.where((l) => l != targetLetter).toList();
    distractors.shuffle();
    List<String> mixed = [targetLetter, ...distractors.take(8)];
    mixed.shuffle();
    return mixed;
  }

  Future<void> _playLetterAudio() async {
    if (state.sampleAssets == null) return;
    final index = state.round - 1;
    if (index < state.sampleAssets!.audioList.length) {
      await _audioPlayer.play(UrlSource(state.sampleAssets!.audioList[index]));
    }
  }

  void setHighlightIndex(int index) {
    state = state.copyWith(highlightIndex: index);
  }

  void clearHighlightIndex() {
    state = state.copyWith(highlightIndex: null);
  }

  Future<void> tapLetter(String tapped, BuildContext context) async {
    if (tapped == state.targetLetter) {
      state = state.copyWith(score: state.score + 1, wrongAttempts: 0);
      _nextRound(context);
    } else {
      final wrong = state.wrongAttempts + 1;
      state = state.copyWith(wrongAttempts: wrong);

      if (wrong == 1 || wrong == 2) {
        await _playReminder();
      }

      if (wrong == 2) {
        await Future.delayed(Duration(seconds: 5));
        _nextRound(context);
      }
    }
  }

  Future<void> _playReminder() async {
    final index = state.round - 1;
    if (index < state.sampleAssets!.failAudios.length) {
      await _audioPlayer.play(UrlSource(state.sampleAssets!.failAudios[index]));
    }
  }

  void _nextRound(BuildContext context) {
    final nextRound = state.round + 1;

    if (nextRound > 10) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: state.score,
            total: 10,
            finishAudios: state.sampleAssets?.finishAudios ?? [],
          ),
        ),
      );
      return;
    }

    final prompt = _getNewTarget(nextRound);
    final target = _extractLetterFromPrompt(prompt);
    final letters = _getShuffledLetters(target);
    state = state.copyWith(
      round: nextRound,
      promptText: prompt,
      targetLetter: target,
      currentLetters: letters,
      wrongAttempts: 0,
    );
    _playLetterAudio();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
