import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../repository/review_repository.dart';
import '../screen/result_screen.dart';
import 'review_event.dart';
import 'review_state.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
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

  ReviewBloc(this.repository) : super(ReviewState()) {
    on<LoadAssets>(_onLoadAssets);
    on<TapLetter>(_onTapLetter);
    on<HighlightLetter>((event, emit) {
      emit(state.copyWith(highlightIndex: event.index));
    });
    on<ClearHighlight>((event, emit) {
      emit(state.copyWith(highlightIndex: null));
    });
  }

  Future<void> _onLoadAssets(
      LoadAssets event, Emitter<ReviewState> emit) async {
    final assets = await repository.fetchSampleAssets();
    if (assets == null) return;

    final prompt = _getNewTarget(1);
    final target = _extractLetterFromPrompt(prompt);
    final letters = _getShuffledLetters(target);

    emit(state.copyWith(
      loading: false,
      sampleAssets: assets,
      promptText: prompt,
      targetLetter: target,
      currentLetters: letters,
    ));

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

  Future<void> _onTapLetter(TapLetter event, Emitter<ReviewState> emit) async {
    if (event.letter == state.targetLetter) {
      emit(state.copyWith(score: state.score + 1, wrongAttempts: 0));
      _nextRound(event.context, emit);
    } else {
      final wrong = state.wrongAttempts + 1;
      emit(state.copyWith(wrongAttempts: wrong));

      if (wrong == 1 || wrong == 2) {
        await _playReminder();
      }

      if (wrong == 2) {
        await Future.delayed(const Duration(seconds: 5));
        _nextRound(event.context, emit);
      }
    }
  }

  Future<void> _playReminder() async {
    final index = state.round - 1;
    if (index < state.sampleAssets!.failAudios.length) {
      await _audioPlayer.play(UrlSource(state.sampleAssets!.failAudios[index]));
    }
  }

  void _nextRound(BuildContext context, Emitter<ReviewState> emit) {
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

    emit(state.copyWith(
      round: nextRound,
      promptText: prompt,
      targetLetter: target,
      currentLetters: letters,
      wrongAttempts: 0,
    ));
    _playLetterAudio();
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
