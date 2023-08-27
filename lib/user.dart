import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uhk_onboarding/api.dart';
import 'package:uhk_onboarding/types.dart';

import 'components/text_field.dart';
import 'helpers.dart';

class UserPage extends StatefulWidget {
  const UserPage(
      {this.user, this.isAdmin = false, this.isEditable = false, super.key});

  final User? user;
  final bool isEditable;
  final bool isAdmin;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _formKey = GlobalKey<FormState>();

  User? get user => widget.user;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  Role? _selectedRole;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: user?.firstName);
    _lastNameController = TextEditingController(text: user?.lastName);
    _usernameController = TextEditingController(text: user?.username);
    _passwordController = TextEditingController();
    _selectedRole = user?.role ?? Role.ghost;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<dynamic> _showAdminAlert() {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
            'You are about to create an admin user. This user will have access to all the data in the app.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('Create'),
            onPressed: () => Navigator.pop(context, true),
          ),
        ],
      ),
    );
  }

  void showError(Response response) {
    String message = response.data['error']['detail'] ?? 'Something went wrong';
    showCupertinoSnackBar(
        context: context, message: 'Error: ${message.capitalize()}');
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${user?.firstName ?? 'New'} ${user?.lastName ?? 'User'}'),
        // leading: CupertinoNavigationBarBackButton(
        //   onPressed: () => Navigator.pop(context, true),
        // ),
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
                    enabled: widget.isEditable || widget.isAdmin,
                    validator: (value) => User.validateFirstName(value),
                  ),
                  CustomCupertinoTextField(
                    placeholder: 'Last name',
                    controller: _lastNameController,
                    prefixIcon: CupertinoIcons.signature,
                    enabled: widget.isEditable || widget.isAdmin,
                    validator: (value) => User.validateLastName(value),
                  ),
                  CustomCupertinoTextField(
                    placeholder: 'Username',
                    controller: _usernameController,
                    prefixIcon: CupertinoIcons.tag,
                    //or globe, gotta decide
                    enabled: widget.isEditable || widget.isAdmin,
                    validator: (value) => User.validateUsername(value),
                  ),
                  if (widget.isEditable || widget.isAdmin)
                    CustomCupertinoTextField(
                      placeholder: 'Password',
                      controller: _passwordController,
                      prefixIcon: CupertinoIcons.lock, //or globe, gotta decide
                      validator: (value) => user == null
                          ? User.validatePassword(value)
                          : null, //There isn't anything to validate, I just need to send the password only when its filled in
                    ),
                  //TODO: Mby add password confirmation
                  CupertinoPicker.builder(
                    itemExtent: 50,
                    scrollController: FixedExtentScrollController(
                        initialItem: _selectedRole!.index),
                    childCount: widget.isAdmin ? Role.values.length : 1,
                    useMagnifier: true,
                    onSelectedItemChanged: widget.isAdmin
                        ? (index) {
                            setState(() {
                              _selectedRole = Role.values[index];
                            });
                          }
                        : null,
                    itemBuilder: (context, index) {
                      final role =
                          widget.isAdmin ? Role.values[index] : _selectedRole!;
                      return Center(
                        child: Text(
                          role.name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  if (widget.isEditable || widget.isAdmin)
                    CupertinoButton.filled(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) return;

                        if (_selectedRole == Role.admin &&
                            user?.role != Role.admin) {
                          final adminConsent = await _showAdminAlert();
                          if (adminConsent == null || !adminConsent) return;
                        } //TODO: Warn/prevent user from demoting themselves

                        showLoadingOverlay(context);

                        User newUser = User(
                          id: user?.id,
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          username: _usernameController.text.trim(),
                          role: _selectedRole!,
                        );
                        if (_passwordController.text.trim() != '') {
                          newUser.password = _passwordController.text.trim();
                        }

                        if (user == null) {
                          final response = await createUser(newUser);
                          if (response.statusCode == 200 ||
                              response.statusCode == 201) {
                            Navigator.pop(context, response.data['payload']);
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => UserPage(
                            //             user: User.fromJson(response.data['payload']),
                            //             isAdmin: true)));
                          } else {
                            showError(response);
                          }
                        } else {
                          if (user != newUser) {
                            final response = await updateUser(newUser);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Navigator.pop(context, response.data['payload']);
                            } else {
                              showError(response);
                            }
                          }
                          if (user!.role != _selectedRole) {
                            final response =
                                await updateRole(newUser.id!, _selectedRole!);
                            if (response.statusCode == 200 ||
                                response.statusCode == 201) {
                              Navigator.pop(context, response.data['payload']);
                            } else {
                              showError(response);
                            }
                          }
                        }
                        hideLoadingOverlay(context);
                      },
                      child: Text('Save'),
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
