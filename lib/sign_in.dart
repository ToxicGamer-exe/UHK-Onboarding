import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uhk_onboarding/api.dart';
import 'package:uhk_onboarding/main.dart';
import 'package:uhk_onboarding/sign_up.dart';

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
        showCupertinoSnackBar(
            context: context, message: widget.customMessage!);
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
  Map<String, String?> errors = {};
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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
                Form(
                  key: _formKey,
                  child: Column(children: [
                    CustomCupertinoTextField(
                      controller: _usernameController,
                      placeholder: 'Username',
                      prefixIcon: CupertinoIcons.tag,
                      //or globe, gotta decide
                      padding: const EdgeInsets.only(bottom: 10.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    CustomCupertinoTextField(
                      key: const Key('password'),
                      placeholder: 'Password',
                      controller: _passwordController,
                      prefixIcon: CupertinoIcons.lock,
                      padding: const EdgeInsets.only(bottom: 10.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
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
                            setState(() {
                              _isLoading = true;
                            });
                            if (_formKey.currentState!.validate()) {
                              final response = await signIn(
                                  _usernameController.value.text.trim(),
                                  _passwordController.value.text.trim());
                              if (response.statusCode == 200) {
                                if (_rememberMe) {
                                  Hive.box('user').put(
                                      'rememberMe', DateTime.now().add(const Duration(days: 7)).toString());
                                }
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyHomePage(
                                            title: 'User Overview')));
                              } else {
                                showCupertinoSnackBar(
                                    context: context,
                                    message:
                                        'Username or password is incorrect');
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
                  ]),
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
          Center(
            child: CupertinoActivityIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
      ],
    );
  }
}
