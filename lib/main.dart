import 'package:flutter/material.dart';

import 'array_func.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<List<String>> board;
  late String attack;

  @override
  void initState() {
    refreshPage();
  }

  bool done() {
    if (doneAsRow(board) || doneAsColumn(board) || doneAsCross(board))
      return true;

    return false;
  }

  void refreshPage() {

  setState(() {
    board = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ];
    attack = 'x';
  });
  }

  void switchUser() => attack = (attack == 'x') ? 'o' : 'x';

  void act(int x, int y) {

    if (board[x][y] == '' && !isFull(board)) {

      setState(() {
        board[x][y] = attack;
        switchUser();


      });

      if (done()) {

        print('done');
       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('peh peh peh')));
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(title: Text(";)"));
            });

        Future.delayed(Duration(seconds: 1) ).then((value) {

          refreshPage();
        }
        );

      }
    }
  }

  Widget buildCard(String txt, double w) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      height: w,
      width: w,
      color: Colors.blueAccent,
      child: Center(
          child: Text(
        txt,
        style: TextStyle(
          color: txt == 'x' ? Colors.yellow :Colors.white,
          fontSize: 40,
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              3,
              (i) => Row(
                    children: List.generate(
                      3,
                      (j) => InkWell(
                          onTap: () {
                            act(i, j);
                          },
                          child: buildCard(board[i][j],
                              (MediaQuery.of(context).size.width -48 )/ 3)),
                    ),
                  )),
        )));
  }
}
