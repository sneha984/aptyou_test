import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/sample_assets.dart';

class ReviewRepository {
  final Dio dio;

  ReviewRepository(this.dio);

  Future<SampleAssets?> fetchSampleAssets() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');
    if (token == null) return null;

    try {
      final response = await dio.get(
        'http://13.60.220.96:8000/content/v5/sample-assets',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return SampleAssets.fromJson(response.data);
    } catch (e) {
      print("Failed to load sample assets: $e");
      return null;
    }
  }
}
