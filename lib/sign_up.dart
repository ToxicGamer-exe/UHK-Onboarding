import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;


  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text('Sign up'),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomCupertinoTextField(
              placeholder: 'First name',
              controller: _firstNameController,
              prefixIcon: CupertinoIcons.person_solid,
            ),
            CustomCupertinoTextField(
              placeholder: 'Last name',
              controller: _lastNameController,
              prefixIcon: CupertinoIcons.signature,
            ),
            CustomCupertinoTextField(
              placeholder: 'Username',
              controller: _usernameController,
              prefixIcon: CupertinoIcons.tag,//or globe, gotta decide
            ),
            CustomCupertinoTextField(
              placeholder: 'Password',
              controller: _passwordController,
              prefixIcon: CupertinoIcons.lock,//or globe, gotta decide
            ),
            SizedBox(height: 5),
            CupertinoButton.filled(
              onPressed: () {
                //TODO: Some pre-validation + API call (Mby reroute and sign in?)
              },
              child: Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}