import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'types.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
  getUsers();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UHK Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'User Overview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [
    // User(1, 'Michael', 'Heinrich', 'mh', Role.admin),
    // User(1, 'Michael', 'Heinrich', 'mh', Role.admin),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
    print("users: " + users.toString());
  }

  void loadData() async {
    final List<User> fetchedUsers = await getUsers();
    print(fetchedUsers);
    setState(() {
      users = fetchedUsers;
      roleCounts = users.map((e) => e.role).fold({}, (Map<String, int> map, String role) {
        map[role] = (map[role] ?? 0) + 1;
        return map;
      });
    });
    // print("Fetched users: " + users.toString());
  }

  //I need to get the counts of roles
  Map<String, int> roleCounts = {
    'admin': 0,
    'manager': 0,
    'technician': 0,
    'asset': 0,
    'ghost': 0,
  };


  //TODO: Add some mock data and try to display the roles in the grid

  //Istg I've done everything to center the last item xD
  //I'm just too lazy to do it with builder instead of count
  List<Widget> _buildGridTileList() =>
      List.generate(
        roleCounts.length,
            (i) =>
            FilledButton(
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
                  Text(roleCounts.values.elementAt(i).toString(), style: const TextStyle(fontSize: 30)),
                  Text(roleCounts.keys.elementAt(i)),
                ],
              ),
            ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEDCDC),
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
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
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 150),
          //   child: FilledButton(
          //     onPressed: null,
          //     child: Column(
          //       children: [
          //         Text('1'),
          //         Text('admin'),
          //       ],
          //     ),
          //     style: ButtonStyle(
          //       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          //           EdgeInsets.all(15)),
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Colors.deepPurple),
          //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //               side: BorderSide(color: Colors.deepPurple))),
          //     ),
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 150),
          //   child: FilledButton(
          //     onPressed: null,
          //     child: Column(
          //       children: [
          //         Text('1'),
          //         Text('admin'),
          //       ],
          //     ),
          //     style: ButtonStyle(
          //       padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          //           EdgeInsets.all(15)),
          //       backgroundColor:
          //           MaterialStateProperty.all<Color>(Colors.deepPurple),
          //       foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10),
          //               side: BorderSide(color: Colors.deepPurple))),
          //     ),
          //   ),
          // ),
          const Divider(
            color: Colors.black,
            height: 25,
            indent: 50,
            endIndent: 50,
          ),
          // Column(
          //   children: [
          for (User user in users)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
              elevation: 2, // No shadow on the card to match iOS style
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16, horizontal: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircleAvatar(radius: 20,
                          child: Text(user.firstName[0] + user.lastName[0])),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text(user.role,
                              style: const TextStyle(fontSize: 16,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    // CupertinoButton(
                    //   onPressed: () {
                    //     // Handle phone button tapped
                    //   },
                    //   child: Icon(CupertinoIcons.phone, size: 30),
                    // ),
                    // CupertinoButton(
                    //   onPressed: () {
                    //     // Handle mail button tapped
                    //   },
                    //   child: Icon(CupertinoIcons.mail, size: 30),
                    // ),
                  ],
                ),
              ),
            ),
          //   ]
          // )
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        tooltip: 'add',
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
