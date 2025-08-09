class SampleAssets {
  final String introAudio;
  final List<String> audioList;
  final List<String> failAudios;
  final List<String> finishAudios;

  SampleAssets({
    required this.introAudio,
    required this.audioList,
    required this.failAudios,
    required this.finishAudios,
  });

  factory SampleAssets.fromJson(Map<String, dynamic> json) {
    final chapter = json['data']['chapter'][0];
    return SampleAssets(
      introAudio: (chapter['introAudios'] as List).first,
      audioList: List<String>.from(chapter['audioList']),
      finishAudios: List<String>.from(chapter['finishAudios']),
      failAudios: List<String>.from(chapter['failAudios']),
    );
  }
}
