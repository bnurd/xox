import 'package:flutter/material.dart';
import 'package:xoxgame/card_component.dart';

import 'array_func.dart';
import 'custom_colors.dart';
import 'line.dart';

import 'line_form.dart';

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
  late Map<String, int> score;
  late int scoreX;
  late int scoreY;
  late bool isDone;

  late LineForm lineForm;
  late int position;

  @override
  void initState() {
    refreshPage();
    score = {'X': 0, 'O': 0};
  }

  bool done() {
    int row = doneAsRow(board);
    int column = doneAsColumn(board);
    int cross = doneAsCross(board);

    if (row != -1) {
      setState(() {
        position = row;
        lineForm = LineForm.HORIZONTAL;
      });
      return true;
    }

    if (column != -1) {
      setState(() {
        position = column;
        lineForm = LineForm.VERTICAL;
      });
      return true;
    }

    if (cross != -1) {
      setState(() {
        position = cross;
        lineForm = LineForm.CROSS;
      });
      return true;
    }

    return false;
  }

  void refreshPage() {
    position = 0;
    lineForm = LineForm.HORIZONTAL;
    isDone = false;
    setState(() {
      board = [
        ['', '', ''],
        ['', '', ''],
        ['', '', '']
      ];
      attack = 'X';
    });
  }

  void switchUser() => attack = (attack == 'X') ? 'O' : 'X';

  void act(int x, int y) {
    if (board[x][y] == '' && !isFull(board)) {
      setState(() {
        board[x][y] = attack;
      });

      if (done()) {
        isDone = true;
        print(score[attack]);

        setState(() {
          score[attack] = (score[attack] ?? 0) + 1;
        });

        Future.delayed(Duration(seconds: 3)).then((value) {
          refreshPage();
         });
      } else {
        switchUser();
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildScoreTable(),
            buildBoard(context),
          ],
        ));
  }

  Container buildBoard(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width),
      child: Padding(
          padding: EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
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
                                type: board[i][j].toUpperCase(),
                                left: j != 0,
                                top: i != 0,
                                bottom: i != 2,
                                right: j != 2,
                              ),
                            ),
                          ),
                        )),
              ),
              if (isDone)
                SizedBox(
                  height: 500,
                  width: 500,
                  child: Line(
                    form: lineForm,
                    position: position,
                    attack: attack,
                  ),
                ),
            ],
          )),
    );
  }

  Widget buildScoreTable() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CardComponent(
          txt: 'X' + '\t\t\t' + (score['X'] == 0 ? '-' : score['X'].toString()),
          type: 'X',
          bottom: attack.toUpperCase() == 'X',
        ),
        CardComponent(
          txt: 'O' + '\t\t\t' + (score['O'] == 0 ? '-' : score['O'].toString()),
          type: 'O',
          bottom: attack.toUpperCase() == 'O',
        ),
      ],
    );
  }
}
