import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:uhk_onboarding/sign_in.dart';

// import './custom_animation.dart';
//
// import './test.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  // ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter EasyLoading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // builder: (context, widget) {
      //   return EasyLoading.init()(context, widget!
      //
      //   );
      // },
      // home: FutureBuilder<String?>(
      //   future: Future.delayed(const Duration(seconds: 2), () => null),
      //   builder: (context, snapshot) => EasyLoading.init()(
      //     context,
      //     FutureBuilder(
      //         future: Future.delayed(const Duration(seconds: 2), () => null),
      //         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return FlutterEasyLoading(
      //                 child: SpinKitSpinningLines(
      //                     color: Theme.of(context).colorScheme.primary));
      //           } else if (snapshot.hasError) {
      //             return Text('Error: ${snapshot.error}');
      //           } else {
      //             return SafeArea(
      //                 child: (snapshot.data == null)
      //                     ? const MyHomePage(title: 'User Overview')
      //                     : SignInPage(customMessage: snapshot.data));
      //           }
      //         }),
      //   ),
      // ),
      // home: FutureBuilder<String?>(
      //   future: Future.delayed(const Duration(seconds: 2), () => null),
      //   builder: (context, snapshot) => EasyLoading.init()(
      //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot, {Widget? child}) {
      //       return FlutterEasyLoading(
      //         child: child!,
      //       );
      //     },
      //   ),
      // )
      // builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //   if (snapshot.connectionState == ConnectionState.waiting) {
      //     return FlutterEasyLoading(
      //         child: SpinKitSpinningLines(
      //             color: Theme.of(context).colorScheme.primary));
      //   } else if (snapshot.hasError) {
      //     return Text('Error: ${snapshot.error}');
      //   } else {
      //     return SafeArea(
      //         child: (snapshot.data == null)
      //             ? const MyHomePage(title: 'User Overview')
      //             : SignInPage(customMessage: snapshot.data));
      //   }
      //   },
      // ),
      // builder: EasyLoading.init(
      //   builder: (context, widget) {
      //     return FutureBuilder<String?>(
      //       future: Future.delayed(const Duration(seconds: 2), () => null),
      //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot,
      //           {Widget? child}) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return FlutterEasyLoading(
      //               child: SpinKitSpinningLines(
      //                   color: Theme.of(context).colorScheme.primary));
      //         } else if (snapshot.hasError) {
      //           return Text('Error: ${snapshot.error}');
      //         } else {
      //           return SafeArea(child: child ?? Container());
      //         }
      //       },
      //     );
      //   },
      // ),
      // builder: (context, widget) {
      //   return EasyLoading.init()(
      //     context,
      //     FutureBuilder<String?>(
      //       future: Future.delayed(const Duration(seconds: 2), () => null),
      //       builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return FlutterEasyLoading(
      //               child: SpinKitSpinningLines(
      //                   color: Theme.of(context).colorScheme.primary));
      //         } else if (snapshot.hasError) {
      //           return Text('Error: ${snapshot.error}');
      //         } else {
      //           return SafeArea(
      //               child: (snapshot.data == null)
      //                   ? const MyHomePage(title: 'User Overview')
      //                   : SignInPage(customMessage: snapshot.data));
      //         }
      //       },
      //     ),
      //   );
      // },
      // builder: EasyLoading.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _timer;
  late double _progress;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      if (status == EasyLoadingStatus.dismiss) {
        _timer?.cancel();
      }
    });
    EasyLoading.showSuccess('Use in initState');
    // EasyLoading.removeCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(),
              Wrap(
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  TextButton(
                    child: Text('open test page'),
                    onPressed: () {
                      _timer?.cancel();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const SignInPage(),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: Text('dismiss'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.dismiss();
                      print('EasyLoading dismiss');
                    },
                  ),
                  TextButton(
                    child: Text('show'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.show(
                        status: 'loading...',
                        maskType: EasyLoadingMaskType.black,
                      );
                      print('EasyLoading show');
                    },
                  ),
                  TextButton(
                    child: Text('showToast'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showToast(
                        'Toast',
                      );
                    },
                  ),
                  TextButton(
                    child: Text('showSuccess'),
                    onPressed: () async {
                      _timer?.cancel();
                      await EasyLoading.showSuccess('Great Success!');
                      print('EasyLoading showSuccess');
                    },
                  ),
                  TextButton(
                    child: Text('showError'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showError('Failed with Error');
                    },
                  ),
                  TextButton(
                    child: Text('showInfo'),
                    onPressed: () {
                      _timer?.cancel();
                      EasyLoading.showInfo('Useful Information.');
                    },
                  ),
                  TextButton(
                    child: Text('showProgress'),
                    onPressed: () {
                      _progress = 0;
                      _timer?.cancel();
                      _timer = Timer.periodic(const Duration(milliseconds: 100),
                          (Timer timer) {
                        EasyLoading.showProgress(_progress,
                            status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress += 0.03;

                        if (_progress >= 1) {
                          _timer?.cancel();
                          EasyLoading.dismiss();
                        }
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Style'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingStyle.dark: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('dark'),
                          ),
                          EasyLoadingStyle.light: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('light'),
                          ),
                          EasyLoadingStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.loadingStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('MaskType'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: CupertinoSegmentedControl<EasyLoadingMaskType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingMaskType.none: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('none'),
                          ),
                          EasyLoadingMaskType.clear: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('clear'),
                          ),
                          EasyLoadingMaskType.black: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('black'),
                          ),
                          EasyLoadingMaskType.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.maskType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Toast Positon'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingToastPosition>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingToastPosition.top: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('top'),
                          ),
                          EasyLoadingToastPosition.center: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('center'),
                          ),
                          EasyLoadingToastPosition.bottom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('bottom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.toastPosition = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  children: <Widget>[
                    Text('Animation Style'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingAnimationStyle>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingAnimationStyle.opacity: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('opacity'),
                          ),
                          EasyLoadingAnimationStyle.offset: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('offset'),
                          ),
                          EasyLoadingAnimationStyle.scale: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('scale'),
                          ),
                          EasyLoadingAnimationStyle.custom: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('custom'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.animationStyle = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 20.0,
                  bottom: 50.0,
                ),
                child: Column(
                  children: <Widget>[
                    Text('IndicatorType(total: 23)'),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child:
                          CupertinoSegmentedControl<EasyLoadingIndicatorType>(
                        selectedColor: Colors.blue,
                        children: {
                          EasyLoadingIndicatorType.circle: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('circle'),
                          ),
                          EasyLoadingIndicatorType.wave: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('wave'),
                          ),
                          EasyLoadingIndicatorType.ring: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('ring'),
                          ),
                          EasyLoadingIndicatorType.pulse: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('pulse'),
                          ),
                          EasyLoadingIndicatorType.cubeGrid: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('cubeGrid'),
                          ),
                          EasyLoadingIndicatorType.threeBounce: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Text('threeBounce'),
                          ),
                        },
                        onValueChanged: (value) {
                          EasyLoading.instance.indicatorType = value;
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
//
//
//
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:uhk_onboarding/helpers.dart';
// import 'package:uhk_onboarding/sign_in.dart';
// import 'package:uhk_onboarding/user.dart';
//
// import 'api.dart';
// import 'components/contact_card.dart';
// import 'types.dart';
//
// void main() async {
//   await Hive.initFlutter();
//   dotenv.load();
//   runApp(const MyApp());
//   EasyLoading.init();
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'UHK Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//             seedColor: Colors.deepPurple, background: const Color(0xFFDEDCDC)),
//         useMaterial3: true,
//       ),
//       builder: EasyLoading.init(
//         builder: (context, child) {
//           return FlutterEasyLoading(
//             child: child!,
//           );
//         },
//       ),
//       home: FutureBuilder<String?>(
//         future: isSignedIn(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return FlutterEasyLoading(
//                 child: SpinKitSpinningLines(
//                     color: Theme.of(context).colorScheme.primary));
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return (snapshot.data == null)
//                 ? const MyHomePage(title: 'User Overview')
//                 : SignInPage(customMessage: snapshot.data);
//           }
//         },
//       ),
//     );
//   }
//
//   Future<String?> isSignedIn() async {
//     final box = await Hive.openBox('user');
//     if (box.containsKey('rememberMe') && box.get('rememberMe') != null) {
//       if (DateTime.parse(box.get('rememberMe')).isAfter(DateTime.now())) {
//         return null;
//       }
//       return 'Your login has expired. Please sign in again.';
//     }
//     return 'Please sign in or sign up.';
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<User> users = [];
//   User? _currentUser;
//
//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loadData();
//   }
//
//   void loadData() async {
//     final List<User> fetchedUsers = await getUsers(limit: 1000);
//     setState(() {
//       users = fetchedUsers;
//       roleCounts =
//           users.map((e) => e.role).fold({}, (Map<Role, int> map, Role role) {
//         map[role] = (map[role] ?? 0) + 1;
//         return map;
//       });
//     });
//     final token = Hive.box('user').get('accessToken');
//     final user = JwtDecoder.decode(token)['user'];
//     if (User.isValid(user)) {
//       setState(() {
//         _currentUser = fetchedUsers.firstWhereOrNull(
//             (element) => element.username == user['username']);
//       });
//     } else {
//       signOut(context, 'Uh oh! Something went wrong... Please sign in again.');
//     }
//     // print("Fetched users: " + users.toString());
//   }
//
//   Map<Role, int> roleCounts = {
//     Role.admin: 0,
//     Role.manager: 0,
//     Role.technician: 0,
//     Role.asset: 0,
//     Role.ghost: 0,
//   };
//
//   //Istg I've done everything to center the last item xD
//   //I'm just too lazy to do it with builder instead of count
//   List<Widget> _buildGridTileList() => List.generate(
//         roleCounts.length,
//         (i) => FilledButton(
//           onPressed: null,
//           style: ButtonStyle(
//             backgroundColor:
//                 MaterialStateProperty.all<Color>(Colors.deepPurple),
//             foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//               RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//                 side: const BorderSide(color: Colors.deepPurple),
//               ),
//             ),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(roleCounts.values.elementAt(i).toString(),
//                   style: const TextStyle(fontSize: 30)),
//               Text(roleCounts.keys.elementAt(i).name.toUpperCase()),
//             ],
//           ),
//         ),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(CupertinoIcons.person_crop_circle),
//           onPressed: () async {
//             final result = await Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => UserPage(
//                       user: _currentUser,
//                       isEditable: true,
//                       isAdmin: _currentUser?.role == Role.admin)),
//             );
//             if (result != null) {
//               loadData();
//               showCupertinoSnackBar(
//                   context: context,
//                   message: "Your profile has been successfully updated.");
//             }
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () => signOut(context, 'You have been signed out.'),
//           ),
//         ],
//       ),
//       body: ListView(
//         children: <Widget>[
//           GridView.count(
//             shrinkWrap: true,
//             crossAxisCount: 2,
//             mainAxisSpacing: 20,
//             crossAxisSpacing: 20,
//             childAspectRatio: 2,
//             padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
//             children: _buildGridTileList(),
//           ),
//           const Divider(
//             color: Colors.black,
//             height: 25,
//             indent: 50,
//             endIndent: 50,
//           ),
//           // Column(
//           //   children: [
//           for (User user in users)
//             ContactCard(
//               user: user,
//               onTap: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => UserPage(
//                             user: user,
//                             isEditable: user == _currentUser,
//                             isAdmin: _currentUser?.role == Role.admin,
//                           )),
//                 );
//                 if (result != null) {
//                   loadData();
//                   final username = result is User
//                       ? result.username
//                       : result is Map<String, dynamic>
//                           ? result['username']
//                           : 'User';
//                   showCupertinoSnackBar(
//                       context: context,
//                       message: '$username was successfully updated.');
//                 }
//               },
//               trailingIcon: _currentUser?.role == Role.admin &&
//                       user !=
//                           _currentUser //It would work even without the second cond (it would just sign him out)
//                   ? Icons.delete
//                   : null,
//               onTrailingIconTap: () async {
//                 showCupertinoModalPopup<void>(
//                     context: context,
//                     builder: (BuildContext context) => CupertinoAlertDialog(
//                           title: const Text('Delete user'),
//                           content: const Text(
//                               'Are you sure you want to delete the user? This action cannot be undone!'),
//                           actions: <CupertinoDialogAction>[
//                             CupertinoDialogAction(
//                               isDefaultAction: true,
//                               onPressed: () => Navigator.pop(context),
//                               child: const Text('No'),
//                             ),
//                             CupertinoDialogAction(
//                               isDestructiveAction: true,
//                               onPressed: () async {
//                                 final response = await deleteUser(user.id!);
//                                 if (response.statusCode == 200) {
//                                   showCupertinoSnackBar(
//                                       context: context,
//                                       message: 'User deleted');
//                                   loadData();
//                                 } else {
//                                   showCupertinoSnackBar(
//                                       context: context,
//                                       message: 'Error deleting user');
//                                   // handleResponseError(response);
//                                 }
//                                 Navigator.pop(context);
//                               },
//                               child: const Text('Yes'),
//                             ),
//                           ],
//                         ));
//               },
//             ),
//         ],
//       ),
//
//       floatingActionButton: _currentUser?.role == Role.admin
//           ? FloatingActionButton(
//               onPressed: () async {
//                 final result = await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const UserPage(isAdmin: true)),
//                 );
//                 if (result != null) {
//                   loadData();
//                   final username = result is User
//                       ? result.username
//                       : result is Map<String, dynamic>
//                           ? result['username']
//                           : 'User';
//                   showCupertinoSnackBar(
//                       context: context,
//                       message: '$username was successfully created.');
//                 }
//               },
//               tooltip: 'add',
//               shape: const CircleBorder(),
//               child: const Icon(Icons.add),
//             )
//           : null,
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
