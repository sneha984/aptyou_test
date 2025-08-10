// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthRepository {
//   final Dio _dio;
//
//   AuthRepository(this._dio);
//
//   Future<String?> signInWithFirebase() async {
//     const url = 'http://13.60.220.96:8000/auth/v5/firebase/signin';
//
//     try {
//       final response = await _dio.post(
//         url,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9',
//             'x-secret-key': 'uG7pK2aLxX9zR1MvWq3EoJfHdTYcBn84',
//           },
//         ),
//       );
//
//       dynamic token;
//
//       if (response.data is Map<String, dynamic>) {
//         token = response.data['accessToken'];
//         if (token == null && response.data['data'] != null) {
//           token = response.data['data']['accessToken'];
//         }
//       }
//
//       if (token != null) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('accessToken', token);
//         return token;
//       } else {
//         return null;
//       }
//     } catch (e) {
//       rethrow;
//     }
//   }
// }
