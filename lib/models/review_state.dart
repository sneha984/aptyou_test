import 'sample_assets.dart';

class ReviewState {
  final bool loading;
  final int round;
  final int score;
  final int wrongAttempts;
  final String promptText;
  final String targetLetter;
  final int? wrongTappedIndex;
  final List<String> currentLetters;
  final int? highlightIndex;
  final int? correctHighlightIndex;
  final SampleAssets? sampleAssets;

  ReviewState({
    this.wrongTappedIndex,
    this.correctHighlightIndex,
    this.loading = true,
    this.round = 1,
    this.score = 0,
    this.wrongAttempts = 0,
    this.promptText = '',
    this.targetLetter = '',
    this.currentLetters = const [],
    this.highlightIndex,
    this.sampleAssets,
  });

  ReviewState copyWith({
    bool? loading,
    int? wrongTappedIndex,
    int? correctHighlightIndex,
    int? round,
    int? score,
    int? wrongAttempts,
    String? promptText,
    String? targetLetter,
    List<String>? currentLetters,
    int? highlightIndex,
    SampleAssets? sampleAssets,
  }) {
    return ReviewState(
      loading: loading ?? this.loading,
      wrongTappedIndex: wrongTappedIndex ?? this.wrongTappedIndex,
      correctHighlightIndex:
          correctHighlightIndex ?? this.correctHighlightIndex,
      round: round ?? this.round,
      score: score ?? this.score,
      wrongAttempts: wrongAttempts ?? this.wrongAttempts,
      promptText: promptText ?? this.promptText,
      targetLetter: targetLetter ?? this.targetLetter,
      currentLetters: currentLetters ?? this.currentLetters,
      highlightIndex: highlightIndex,
      sampleAssets: sampleAssets ?? this.sampleAssets,
    );
  }
}
