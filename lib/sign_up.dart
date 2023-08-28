import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_onboarding/api.dart';
import 'package:uhk_onboarding/types.dart';

import 'components/text_field.dart';
import 'helpers.dart';
import 'main.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Sign up'),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomCupertinoTextField(
                    placeholder: 'First name',
                    controller: _firstNameController,
                    prefixIcon: CupertinoIcons.person_solid,
                    validator: (value) => User.validateFirstName(value),
                  ),
                  CustomCupertinoTextField(
                    placeholder: 'Last name',
                    controller: _lastNameController,
                    prefixIcon: CupertinoIcons.signature,
                    validator: (value) => User.validateLastName(value),
                  ),
                  CustomCupertinoTextField(
                    placeholder: 'Username',
                    controller: _usernameController,
                    prefixIcon: CupertinoIcons.tag,
                    validator: (value) => User.validateUsername(value),
                  ),
                  CustomCupertinoTextField(
                    placeholder: 'Password',
                    controller: _passwordController,
                    prefixIcon: CupertinoIcons.lock,
                    validator: (value) => User.validatePassword(value),
                  ),
                  if(_passwordController.text.isNotEmpty)
                  CustomCupertinoTextField(
                      placeholder: 'Password confirm',
                      controller: _passwordConfirmController,
                      prefixIcon: CupertinoIcons.lock_rotation,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      }),
                  SizedBox(height: 5),
                  CupertinoButton.filled(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;

                      showLoadingOverlay(context);

                      final response = await signUp(User(
                        firstName: _firstNameController.text.trim(),
                        lastName: _lastNameController.text.trim(),
                        username: _usernameController.text.trim(),
                        password: _passwordController.text.trim(),
                      ));
                      if (response.statusCode == 200) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const MyHomePage(title: 'User Overview')));
                      } else {
                        String message =
                            response.data['message']?.elementAt(0) ??
                                'Something went wrong';
                        showCupertinoSnackBar(
                            context: context,
                            message: 'Error: ${message.capitalize()}');
                        // handleResponseError(response);
                      }

                      hideLoadingOverlay(context);
                    },
                    child: const Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
