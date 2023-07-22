import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
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
  //TODO: Add some mock data and try to display the roles in the grid
  List<Widget> _buildGridTileList(int count) => List.generate(
    count,
        (i) => FilledButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.deepPurple),
            ),
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('1', style: TextStyle(fontSize: 30)),
            Text('admin'),
          ],
        ),
      ),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDEDCDC),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
            children: _buildGridTileList(4),
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
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            elevation: 2, // No shadow on the card to match iOS style
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: const Row(
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircleAvatar(radius: 20, child: Text('MH')),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Michael Heinrich',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('admin',
                            style: TextStyle(fontSize: 16, color: Colors.grey)),
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
          // Add more Card widgets for other contacts
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
