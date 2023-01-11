import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScrollExam extends StatefulWidget {
  const ScrollExam({super.key});

  @override
  State<ScrollExam> createState() => _ScrollExamState();
}

class _ScrollExamState extends State<ScrollExam> {
  var colors = [
    Colors.grey,
    Colors.accents,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                color: Colors.amber,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        color: Colors.red,
                      ),
                      Container(
                        height: 500,
                        color: Colors.blue,
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.green,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: PageView.builder(
                                controller: PageController(
                                  initialPage: 0, //시작 페이지
                                ),
                                itemCount: colors.length, //페이지 수
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    color: Colors.cyan,
                                    child: Text(
                                      '$index',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  );
                                }, //page 의 반목문 항목 형성
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
