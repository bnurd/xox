import 'package:flutter/material.dart';
import 'package:xoxgame/card_component.dart';

import 'array_func.dart';
import 'custom_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


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

        Future.delayed(Duration(seconds: 1)).then((value) {
          refreshPage();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the MyHomePage object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: Text(widget.title),
        // ),
        backgroundColor: CustomColors.bgColor,
        body: Padding(
            padding: EdgeInsets.all(20),
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
                            child: CardComponent(
                              txt: board[i][j].toUpperCase(),
                              left: j != 0,
                              top: i != 0,
                              bottom: i != 2,
                              right: j != 2,
                            ),
                          ),
                        ),
                      )),
            )));
  }
}
