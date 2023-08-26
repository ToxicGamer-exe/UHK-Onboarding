import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:uhk_onboarding/types.dart';

String? key = Hive.box('user').get('accessToken');

final dio = Dio(BaseOptions(
    baseUrl: dotenv.maybeGet('API_URL') ?? '',
    contentType: 'application/json',
    responseType: ResponseType.json,
    validateStatus: (status) => status! < 500,
    headers: {
      "Authorization": "Bearer $key",
    }));

FutureOr<List<User>> getUsers({int limit = 50}) async {
  final response = await dio.get('/users', queryParameters: {'limit': limit});
  return response.data['payload'].map<User>((e) => User.fromJson(e)).toList(); //Futures.wait()?
}

Future<Response> signIn(String username, String password) async {
  late Response response;

  try {
    response = await dio.post('/auth/signin',
        data: json.encode({'username': username, 'password': password}));
    key = response.data['payload']['accessToken'];
    Hive.box('user').put('accessToken', key);
    dio.options.headers = {"Authorization": "Bearer $key"};
  } catch (e) {
    print(e);
  }

  return response;
}

Future<Response> signUp(User user) async {
  late Response response;

  try {
    response = await dio.post('/auth/signup', data: user.toJson());
  } catch (e) {
    print(e);
  }
  if(response.statusCode == 200) {
    return await signIn(user.username, user.password!);
  }

  return response;
}

Future<Response> createUser(User user) async {
  print("Creating user with: " + user.toString());
  late Response response;

  try {
    response = await dio.post('/users', data: user.toJson());
  } catch (e) {
    print(e);
  }

  print(response);
  return response;
}


Future<Response> updateUser(User user) async {
  late Response response;

  try {
    response = await dio.put('/users/${user.id}', data: user.toJson());
  } catch (e) {
    print(e);
  }

  return response;
}

Future<Response> updateRole(int id, Role role) async {
  print("Updating user with: " + role.toString());
  late Response response;

  try {
    response = await dio.put('/users/$id/role', data: {'role': role.name.toLowerCase()});
  } catch (e) {
    print(e);
  }

  print(response);
  return response;
}

Future<Response> deleteUser(int id) async {
  late Response response;

  try {
    response = await dio.delete('/users/$id');
  } catch (e) {
    print(e);
  }

  return response;
}