import 'dart:async';

import 'package:dio/dio.dart';
import 'package:uhk_onboarding/types.dart';

final dio = Dio();

FutureOr<List<User>> getUsers() async {
  final response = await dio.get('https://am-api.inqubi.eu/api/v1/users?limit=3',
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImZpcnN0bmFtZSI6IkpvaG4iLCJsYXN0bmFtZSI6IkRvZSIsInVzZXJuYW1lIjoiamRvZSIsInJvbGUiOiJnaG9zdCJ9LCJpYXQiOjE2OTAxMDEyMzcsImV4cCI6MTY5MDcwNjAzN30.sSj0Px6GRQlNX2U2EWp2V5fvhlxVyHXkySwmxizjSis",
      }));
      // .then((value) => value.data['data'].map<User>((e) => User.fromJson(e)).toList());
  // print("Response: " + response.data['payload'].toString());
  return response.data['payload'].map<User>((e) => User.fromJson(e)).toList();
  // return response.data['payload'] as List<User>;
}
