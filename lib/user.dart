import 'package:flutter/cupertino.dart';
import 'package:uhk_onboarding/types.dart';

import 'components/text_field.dart';

class UserPage extends StatefulWidget {
  const UserPage({this.user, super.key});

  final User? user;

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _usernameController;
  late TextEditingController _roleController;

  get user => widget.user;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: user?.firstName);
    _lastNameController = TextEditingController(text: user?.lastName);
    _usernameController = TextEditingController(text: user?.username);
    _roleController = TextEditingController(text: user?.role);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
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
            ),
            SizedBox(height: 15),
            CustomCupertinoTextField(
              placeholder: 'Last name',
              controller: _lastNameController,
              prefixIcon: CupertinoIcons.signature,
            ),
            SizedBox(height: 15),
            CustomCupertinoTextField(
              placeholder: 'Username',
              controller: _usernameController,
              prefixIcon: CupertinoIcons.tag,//or globe, gotta decide
            ),
            SizedBox(height: 15),
            CupertinoPicker.builder(
              itemExtent: 50,
              onSelectedItemChanged: null,
              childCount: Role.values.length,
              useMagnifier: true,
              itemBuilder: (context, index) {
                final role = Role.values[index];
                return Center(
                  child: Text(
                    role.name.toUpperCase(),
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
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
