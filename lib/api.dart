import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uhk_onboarding/types.dart';

String? key;

final dio = Dio(BaseOptions(
    baseUrl: dotenv.maybeGet('API_URL') ?? '',
    contentType: 'application/json',
    responseType: ResponseType.json,
    headers: {
      "Authorization": "Bearer $key",
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
    key = response.data['payload']['accessToken'];
    dio.options.headers = {"Authorization": "Bearer $key"};
  } catch (e) {
    print(e);
  }
  print(response);
  return response;
}

Future<Response> signUp(User user) async {
  print("Signing up with: " + user.toString());
  Response response = Response(requestOptions: RequestOptions());

  try {
    response = await dio.post('/auth/signup', data: json.encode(user));
  } catch (e) {
    print(e);
  }
  print(response);
  return response;
}

Future<Response> updateUser(User user) async {
  print("Updating user with: " + user.toString());
  Response response = Response(requestOptions: RequestOptions());

  try {
    response = await dio.put('/users/${user.id}', data: json.encode(user));
  } catch (e) {
    print(e);
  }
  print(response);
  return response;
}

Future<Response> deleteUser(int id) async {
  print("Deleting user with id: " + id.toString());
  Response response = Response(requestOptions: RequestOptions());

  try {
    response = await dio.delete('/users/$id');
  } catch (e) {
    print(e);
  }
  print(response);
  return response;
}