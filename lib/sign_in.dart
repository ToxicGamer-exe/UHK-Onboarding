import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uhk_onboarding/api.dart';
import 'package:uhk_onboarding/main.dart';
import 'package:uhk_onboarding/sign_up.dart';

import 'components/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

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
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _rememberMe = false;
  Map<String, String?> errors = {};
  bool _isLoading = false;

  void validate() {
    setState(() {
      errors = {};
    });
    if (_usernameController.value.text.trim().isEmpty) {
      setState(() {
        errors['username'] = 'Username cannot be empty';
      });
    }
    if (_passwordController.value.text.trim().isEmpty) {
      setState(() {
        errors['password'] = 'Password cannot be empty';
      });
    }
  }

  //So weird thing here actually, when theres some error from the server, the response is null xD
  //So I basically have no way of handling errors :))

  // void handleResponseError(Response response) {
  //   //handle if username or password is wrong or not found
  //   print(response);
  //   print(response.statusMessage);
  //   if (response.statusMessage == 'Bad bad request.') {
  //     setState(() {
  //       errors['username'] = 'Username not found';
  //     });
  //   } else if (response.statusCode == 401) {
  //     setState(() {
  //       errors['password'] = 'Password is incorrect';
  //     });
  //   } else {
  //     setState(() {
  //       errors['username'] = 'Something went wrong';
  //       errors['password'] = 'Something went wrong';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Sign in'),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomCupertinoTextField(
                  placeholder: 'Username',
                  controller: _usernameController,
                  prefixIcon: CupertinoIcons.tag,
                  //or globe, gotta decide
                  onClearPressed: () => _usernameController.clear(),
                  errorText: errors['username'],
                ),
                const SizedBox(height: 10),
                CustomCupertinoTextField(
                  placeholder: 'Password',
                  controller: _passwordController,
                  prefixIcon: CupertinoIcons.lock,
                  //or globe, gotta decide
                  onClearPressed: () => _passwordController.clear(),
                  errorText: errors['password'],
                ),
                const SizedBox(height: 10),
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
                const SizedBox(height: 20),
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
                        setState(() {
                          _isLoading = true;
                        });
                        validate();
                        if (errors.isEmpty) {
                          final response = await signIn(
                              _usernameController.value.text.trim(),
                              _passwordController.value.text.trim());
                          if (response.statusCode == 200) {
                            if (_rememberMe) {
                              //TODO: Encrypt something so you can't just sign in as someone else
                              //TODO: Save access token? (rn its in .env)
                              Hive.box('user').put('username',
                                  _usernameController.value.text.trim());
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage(
                                        title: 'User Overview')));
                          } else {
                            setState(() {
                              errors['username'] = 'Wrong username or password';
                              errors['password'] = 'Wrong username or password';
                            });
                            // handleResponseError(response);
                          }
                        }
                        setState(() {
                          _isLoading = false;
                        });
                      },
                      child: const Text('Sign in'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
