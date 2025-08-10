import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssets extends ReviewEvent {}

class TapLetter extends ReviewEvent {
  final String letter;
  final BuildContext context;

  const TapLetter(this.letter, this.context);

  @override
  List<Object?> get props => [letter, context];
}

class HighlightLetter extends ReviewEvent {
  final int index;
  const HighlightLetter(this.index);

  @override
  List<Object?> get props => [index];
}

class ClearHighlight extends ReviewEvent {}
