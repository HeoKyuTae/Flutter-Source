import 'dart:async';
import 'package:flutter/material.dart';

class Game1 extends StatefulWidget {
  const Game1({super.key});

  @override
  State<Game1> createState() => _Game1State();
}

class _Game1State extends State<Game1> {
  late Timer timer;
  var time = 0;
  List rankList = [];

  int check = 0;
  List clist = [];

  bool isStart = true;
  int score = 0;

  List select = [];
  List data = [];

  start() {
    int r = 0;
    data = [];
    select = [];

    for (var i = 0; i < 19; i++) {
      if (r == 2) {
        break;
      } else {
        if (i == 18) {
          i = -1;
          r += 1;
        } else {
          data.add('-');
          select.add('-');
        }
      }
    }

    setState(() {
      data.shuffle();
    });
  }

  startTimer() {
    time = 0;

    timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        time++;
      });
    });
  }

  gameSet() {
    startTimer();

    isStart = false;
    int r = 0;
    score = 0;
    data = [];
    select = [];

    for (var i = 0; i < 19; i++) {
      if (r == 2) {
        break;
      } else {
        if (i == 18) {
          i = -1;
          r += 1;
        } else {
          data.add('${i + 1}');
          select.add('-');
        }
      }
    }

    setState(() {
      data.shuffle();
    });
  }

  @override
  void initState() {
    start();
    super.initState();
  }

  de() {
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        clist = [];
      });
    });
  }

  gameover() {
    int sum = 0;

    for (var i = 0; i < data.length; i++) {
      if (data[i] != '-') {
        sum += 1;
      }
    }

    if (sum == 0) {
      timer.cancel();
      return false;
    } else {
      return true;
    }
  }

  ti() {
    var sec = time / 100;
    var hundredth = '${time % 100}'.padLeft(2, '0');

    return '$sec$hundredth';
  }

  rank() {
    var sec = time / 100;
    var hundredth = '${time % 100}'.padLeft(2, '0');

    Map<String, dynamic> map = {
      'time': '$sec$hundredth',
      'score': score,
    };

    rankList.add(map);
  }

  shuffle() {
    setState(() {
      data.shuffle();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                color: Colors.black,
              ),
              Container(
                width: size.width,
                height: size.width,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      color: Colors.white,
                      child: Image.asset('assets/images/ic_main_ic_main_top_logo.png'),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        childAspectRatio: 1 / 1,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (isStart = gameover() == false) {
                              print('Game over');
                              rank();
                              return;
                            }

                            if (!clist.contains(index)) {
                              setState(() {
                                clist.add(index);
                                check += 1;
                              });
                            }

                            if (check == 2) {
                              print(clist);

                              setState(() {
                                var first = data[clist[0]];
                                var second = data[clist[1]];

                                if (first == second) {
                                  if (data.asMap().containsKey(clist[0])) {
                                    data[clist[0]] = '-';
                                  }

                                  if (data.asMap().containsKey(clist[1])) {
                                    data[clist[1]] = '-';
                                  }

                                  check = 0;
                                  score += 10;
                                  de();
                                } else {
                                  check = 0;
                                  score -= 10;
                                  de();
                                  shuffle();
                                }
                              });

                              if (isStart = gameover() == false) {
                                print('Game over');
                                rank();
                                return;
                              }
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(1),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              color: clist.contains(index) ? Colors.amber : Colors.red,
                              alignment: Alignment.center,
                              child: Text(data[index]),
                            ),
                          ),
                        );
                      }, //item 의 반목문 항목 형성
                    ),
                    isStart == false
                        ? const SizedBox.shrink()
                        : Container(
                            color: Colors.black.withOpacity(0.3),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/game-over.png',
                                    width: 120,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        gameSet();
                                      },
                                      child: const Text('START'))
                                ],
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              Container(
                height: 44,
                alignment: Alignment.centerLeft,
                color: Colors.grey.withOpacity(0.3),
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Row(
                  children: [
                    const Text('Timer :'),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(ti()),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: 44,
                alignment: Alignment.centerLeft,
                color: Colors.grey.withOpacity(0.3),
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Row(
                  children: [
                    const Text('점수 :'),
                    const SizedBox(
                      width: 16,
                    ),
                    Text('$score'),
                  ],
                ),
              ),
              Container(
                height: 60,
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Ranking',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                child: ListView.separated(
                  itemCount: rankList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 44,
                      padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: Row(
                        children: [
                          Container(
                            width: 33,
                            height: 33,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(44),
                            ),
                            child: Text(
                              '$index',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('${rankList[index]['time']}'),
                          const SizedBox(
                            width: 16,
                          ),
                          Text('${rankList[index]['score']}'),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.black,
                      indent: 8,
                      endIndent: 8,
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
