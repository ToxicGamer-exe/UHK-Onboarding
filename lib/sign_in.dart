import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:uhk_onboarding/api.dart';
import 'package:uhk_onboarding/main.dart';
import 'package:uhk_onboarding/sign_up.dart';
import 'package:uhk_onboarding/types.dart';

import 'components/text_field.dart';
import 'helpers.dart';

class SignInPage extends StatefulWidget {
  final String? customMessage;

  const SignInPage({super.key, this.customMessage});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    if (widget.customMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCupertinoSnackBar(context: context, message: widget.customMessage!);
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _rememberMe = false;
  final _formKey = GlobalKey<FormState>();

  String handleResponseError(Response response) {
    switch (response.data?['meta']?['code']) {
      case 'api.error.bad_request':
        return 'Username not found';
      case 'api.error.authorization.wrong_credentials':
        return 'Wrong password';
      default:
        return 'Something went wrong';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Sign in'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(children: [
                CustomCupertinoTextField(
                  placeholder: 'Username',
                  controller: _usernameController,
                  prefixIcon: CupertinoIcons.tag,
                  //or globe, gotta decide
                  padding: const EdgeInsets.only(bottom: 10.0),
                  validator: (value) => User.validateUsername(value),
                ),
                CustomCupertinoTextField(
                  placeholder: 'Password',
                  controller: _passwordController,
                  prefixIcon: CupertinoIcons.lock,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  validator: (value) => User.validatePassword(value),
                ),
                Row(
                  children: [
                    Transform.scale(
                      scale: 0.75,
                      child: CupertinoSwitch(
                        value: _rememberMe,
                        onChanged: (newValue) {
                          setState(() {
                            _rememberMe = newValue;
                          });
                        },
                      ),
                    ),
                    const DefaultTextStyle(
                      style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.secondaryLabel,
                      ),
                      child: Text(
                        'Remember Me',
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage())),
                      padding: const EdgeInsets.all(12.0),
                      borderRadius: BorderRadius.circular(30.0),
                      color: CupertinoColors.lightBackgroundGray,
                      child: const Icon(
                        CupertinoIcons.at_badge_plus,
                        color: CupertinoColors.activeBlue,
                        size: 24.0,
                      ),
                    ),
                    CupertinoButton.filled(
                      onPressed: () async {
                        print('Signing in...');
                        await EasyLoading.showInfo('Signing in...', duration: const Duration(seconds: 10));
                        await Future.delayed(const Duration(seconds: 3));
                        print('Signed in');
                        return;
                        if (!_formKey.currentState!.validate()) return;

                        final response = await signIn(
                            _usernameController.value.text.trim(),
                            _passwordController.value.text.trim());
                        if (response.statusCode == 200) {
                          if (_rememberMe) {
                            Hive.box('user').put(
                                'rememberMe',
                                DateTime.now()
                                    .add(const Duration(days: 7))
                                    .toString());
                          }
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                      title: 'User Overview')));
                        } else {
                          String message = handleResponseError(response);
                          showCupertinoSnackBar(
                              context: context,
                              message: 'Error: ${message.capitalize()}');
                        }
                        await EasyLoading.dismiss();
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
