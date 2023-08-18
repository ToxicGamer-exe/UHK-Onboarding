import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            CustomCupertinoTextField(
              placeholder: 'Username',
              controller: _usernameController,
              prefixIcon: CupertinoIcons.tag, //or globe, gotta decide
              onClearPressed: () => _usernameController.clear(),
            ),
            const SizedBox(height: 10),
            CustomCupertinoTextField(
              placeholder: 'Password',
              controller: _passwordController,
              prefixIcon: CupertinoIcons.lock, //or globe, gotta decide
              onClearPressed: () => _passwordController.clear(),
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
                  //TODO: Some pre-validation + API call
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'User Overview'))),
                  child: const Text('Sign in'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
