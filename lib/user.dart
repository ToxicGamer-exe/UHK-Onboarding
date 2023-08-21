import 'package:flutter/cupertino.dart';
import 'package:uhk_onboarding/types.dart';

import 'components/text_field.dart';

class UserPage extends StatefulWidget {
  const UserPage({this.user, this.isEditable = false, super.key});

  final User? user;
  final bool isEditable;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _roleController;

  get user => widget.user;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: user?.firstName);
    _lastNameController = TextEditingController(text: user?.lastName);
    _usernameController = TextEditingController(text: user?.username);
    _passwordController = TextEditingController(text: user?.password);
    _roleController = TextEditingController(text: user?.role);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('${user?.firstName ?? 'New'} ${user?.lastName ?? 'User'}'),
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
              enabled: widget.isEditable,
            ),
            CustomCupertinoTextField(
              placeholder: 'Last name',
              controller: _lastNameController,
              prefixIcon: CupertinoIcons.signature,
              enabled: widget.isEditable,
            ),
            CustomCupertinoTextField(
              placeholder: 'Username',
              controller: _usernameController,
              prefixIcon: CupertinoIcons.tag, //or globe, gotta decide
              enabled: widget.isEditable,
            ),
            if(widget.isEditable)
              CustomCupertinoTextField(
                placeholder: 'Password',
                controller: _passwordController,
                prefixIcon: CupertinoIcons.lock, //or globe, gotta decide
              ),
            CupertinoPicker.builder(
              itemExtent: 50,
              scrollController: FixedExtentScrollController(
                  initialItem: Role.values.indexWhere((element) =>
                  element
                      .name == user?.role)),
              onSelectedItemChanged: null,
              childCount: widget.isEditable ? Role.values.length : 1,
              useMagnifier: true,
              itemBuilder: (context, index) {
                if (!widget.isEditable) {
                  return Center(child: Text(user.role.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)));
                }
                final role = Role.values[index];
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
            if(widget.isEditable)
              CupertinoButton.filled(
                onPressed: () {
                  //TODO: Validation + API call
                },
                child: Text('Save'),
              ),
          ],
        ),
      ),
    );
  }
}
