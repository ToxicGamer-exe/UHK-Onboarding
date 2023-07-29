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
            CupertinoTextField(
              placeholder: 'First name',
              controller: _firstNameController,
              prefix: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  CupertinoIcons.person_solid,
                  color: CupertinoColors.systemGrey,
                  size: 28,
                ),
              ),
              suffix: CupertinoButton(
                child: Icon(
                  CupertinoIcons.clear_thick_circled,
                  size: 28,
                ),
                onPressed: () => _firstNameController.clear(),
              ),
              suffixMode: OverlayVisibilityMode.editing,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(height: 20),
            CustomCupertinoTextField(
              placeholder: 'Last name',
              controller: _lastNameController,
              prefixIcon: CupertinoIcons.signature,
              onClearPressed: () => _lastNameController.clear(),
            ),
            SizedBox(height: 20),
            CustomCupertinoTextField(
              placeholder: 'Username',
              controller: _usernameController,
              prefixIcon: CupertinoIcons.tag,//or globe, gotta decide
              onClearPressed: () => _usernameController.clear(),
            ),
            SizedBox(height: 20),
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
