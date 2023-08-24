import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:uhk_onboarding/helpers.dart';
import 'package:uhk_onboarding/sign_in.dart';
import 'package:uhk_onboarding/user.dart';
import 'components/contact_card.dart';
import 'types.dart';
import 'api.dart';

void main() async {
  await Hive.initFlutter();
  dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UHK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, background: const Color(0xFFDEDCDC)),
        useMaterial3: true,
      ),
      home: FutureBuilder<String?>(
        future: isSignedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.primary));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return (snapshot.data == null)
                ? const MyHomePage(title: 'User Overview')
                : SignInPage(customMessage: snapshot.data);
          }
        },
      ),
    );
  }

  Future<String?> isSignedIn() async {
    final box = await Hive.openBox('user');
    if (box.containsKey('rememberMe') && box.get('rememberMe') != null) {
      if (DateTime.parse(box.get('rememberMe')).isAfter(DateTime.now())) {
        return null;
      }
      return 'Your login has expired. Please sign in again.';
    }
    return 'Please sign in or sign up.';
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  User? _currentUser;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final List<User> fetchedUsers = await getUsers(limit: 1000);
    setState(() {
      users = fetchedUsers;
      roleCounts =
          users.map((e) => e.role).fold({}, (Map<Role, int> map, Role role) {
        map[role] = (map[role] ?? 0) + 1;
        return map;
      });
    });
    final token = Hive.box('user').get('accessToken');
    final user = JwtDecoder.decode(token)['user'];
    if (User.isValid(user)) {
      setState(() {
        _currentUser = fetchedUsers.firstWhereOrNull(
            (element) => element.username == user['username']);
      });
    } else {
      signOut(context, 'Uh oh! Something went wrong... Please sign in again.');
    }
    // print("Fetched users: " + users.toString());
  }

  Map<Role, int> roleCounts = {
    Role.admin: 0,
    Role.manager: 0,
    Role.technician: 0,
    Role.asset: 0,
    Role.ghost: 0,
  };

  //Istg I've done everything to center the last item xD
  //I'm just too lazy to do it with builder instead of count
  List<Widget> _buildGridTileList() => List.generate(
        roleCounts.length,
        (i) => FilledButton(
          onPressed: null,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurple),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.deepPurple),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(roleCounts.values.elementAt(i).toString(),
                  style: const TextStyle(fontSize: 30)),
              Text(roleCounts.keys.elementAt(i).name.toUpperCase()),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.person_crop_circle),
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserPage(
                      user: _currentUser,
                      isEditable: true,
                      isAdmin: _currentUser?.role == Role.admin)),
            );
            if (result != null) {
              loadData();
              showCupertinoSnackBar(context: context, message: "Your profile has been successfully updated.");
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => signOut(context, 'You have been signed out.'),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 2,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            children: _buildGridTileList(),
          ),
          const Divider(
            color: Colors.black,
            height: 25,
            indent: 50,
            endIndent: 50,
          ),
          // Column(
          //   children: [
          for (User user in users)
            ContactCard(
              user: user,
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserPage(
                            user: user,
                            isEditable: user == _currentUser,
                            isAdmin: _currentUser?.role == Role.admin,
                          )),
                );
                if (result != null) {
                  loadData();
                  final username = result is User
                      ? result.username
                      : result is Map<String, dynamic>
                      ? result['username']
                      : 'User';
                  showCupertinoSnackBar(context: context, message: '$username was successfully updated.');
                }
              },
              trailingIcon: _currentUser?.role == Role.admin &&
                      user !=
                          _currentUser //It would work even without the second cond (it would just sign him out)
                  ? Icons.delete
                  : null,
              onTrailingIconTap: () async {
                showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                          title: const Text('Delete user'),
                          content: const Text(
                              'Are you sure you want to delete the user? This action cannot be undone!'),
                          actions: <CupertinoDialogAction>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () => Navigator.pop(context),
                              child: const Text('No'),
                            ),
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              onPressed: () async {
                                final response = await deleteUser(user.id!);
                                if (response.statusCode == 200) {
                                  showCupertinoSnackBar(
                                      context: context,
                                      message: 'User deleted');
                                  loadData();
                                } else {
                                  showCupertinoSnackBar(
                                      context: context,
                                      message: 'Error deleting user');
                                  // handleResponseError(response);
                                }
                                Navigator.pop(context);
                              },
                              child: const Text('Yes'),
                            ),
                          ],
                        ));
              },
            ),
        ],
      ),

      floatingActionButton: _currentUser?.role == Role.admin
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserPage(isAdmin: true)),
                );
                if (result != null) {
                  loadData();
                  final username = result is User
                      ? result.username
                      : result is Map<String, dynamic>
                          ? result['username']
                          : 'User';
                  showCupertinoSnackBar(context: context, message: '$username was successfully created.');
                }
              },
              tooltip: 'add',
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            )
          : null,
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
