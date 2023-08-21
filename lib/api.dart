import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uhk_onboarding/types.dart';

final dio = Dio(BaseOptions(
    baseUrl: dotenv.maybeGet('API_URL') ?? '',
    contentType: 'application/json',
    responseType: ResponseType.json,
    headers: {
      "Authorization": dotenv.maybeGet('API_KEY'),
    }));

FutureOr<List<User>> getUsers({int limit = 50}) async {
  final response = await dio.get('/users', queryParameters: {'limit': limit});
  // .then((value) => value.data['data'].map<User>((e) => User.fromJson(e)).toList());
  // print("Response: " + response.data['payload'].toString());
  return response.data['payload'].map<User>((e) => User.fromJson(e)).toList(); //Futures.wait()?
  // return response.data['payload'] as List<User>;
}

Future<Response> signIn(String username, String password) async {
  print("Signing in with: " + username + " " + password);
  Response response = Response(requestOptions: RequestOptions());

  try {
    response = await dio.post('/auth/signin',
        data: json.encode({'username': username, 'password': password}));
  } catch (e) {
    print(e);
  }
  print(response);
  return response;
}
