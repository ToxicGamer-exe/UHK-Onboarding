import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uhk_onboarding/types.dart';

final dio = Dio();

FutureOr<List<User>> getUsers({int limit = 50}) async {
  final response = await dio.get('${dotenv.maybeGet('API_URL')}/users?limit=$limit',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": dotenv.maybeGet('API_KEY'),
      }));
      // .then((value) => value.data['data'].map<User>((e) => User.fromJson(e)).toList());
  // print("Response: " + response.data['payload'].toString());
  return response.data['payload'].map<User>((e) => User.fromJson(e)).toList();
  // return response.data['payload'] as List<User>;
}
