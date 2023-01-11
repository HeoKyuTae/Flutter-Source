import 'dart:math';

import 'package:flutter/material.dart';
import 'package:make_source/sticker.dart';

class Box1 extends StatefulWidget {
  const Box1({super.key});

  @override
  State<Box1> createState() => _Box1State();
}

class _Box1State extends State<Box1> {
  final Random _random = Random();
  List<Widget> boxlist = [];
  Offset offset = const Offset(0, 0);
  double count = 0;

  @override
  void initState() {
    for (var i = 0; i < 3; i++) {
      boxlist.add(Sticker(
        size: const Size(100, 100),
        offset: offset * count,
        color: color(),
      ));
      count++;
    }

    super.initState();
  }

  color() {
    return Color.fromARGB(
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: size.width,
                decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.3))),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Container(color: Colors.grey[200], child: Stack(fit: StackFit.expand, children: boxlist));
                  },
                ),
              ),
              Expanded(child: Container()),
              Container(
                alignment: Alignment.center,
                color: Colors.blue,
                height: 60,
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Insert',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
