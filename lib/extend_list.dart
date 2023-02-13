import 'package:flutter/material.dart';

class ExtendList extends StatefulWidget {
  const ExtendList({super.key});

  @override
  State<ExtendList> createState() => _ExtendListState();
}

class _ExtendListState extends State<ExtendList> with TickerProviderStateMixin {
  late TabController _tabController;
  final scrollController = ScrollController();

  double mainHeight = 400;
  double subHeight = 44;
  bool isShow = false;

  @override
  void initState() {
    scrollController.addListener(_addListener);
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  _addListener() {
    if (scrollController.offset > mainHeight) {
      isShow = true;
    } else {
      isShow = false;
    }

    setState(() {});
  }

  Widget main() {
    return Column(
      children: [
        Container(
          height: mainHeight,
          color: Colors.red,
          child: Image.asset(
            'assets/images/t.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: 1,
          color: Colors.black,
        )
      ],
    );
  }

  Widget sub() {
    return Column(
      children: [
        Container(
          height: subHeight,
          color: Colors.green,
          child: TabBar(
            tabs: [
              Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  'Tab1',
                ),
              ),
              Container(
                height: 80,
                alignment: Alignment.center,
                child: Text(
                  'Tab2',
                ),
              ),
            ],
            indicator: BoxDecoration(
              gradient: LinearGradient(
                //배경 그라데이션 적용
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blueAccent,
                  Colors.pinkAccent,
                ],
              ),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            controller: _tabController,
          ),
        ),
        Container(
          height: 1,
          color: Colors.black,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      index == 0
                          ? Column(
                              children: [main(), sub()],
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                        child: Container(
                          alignment: Alignment.center,
                          height: 100,
                          color: Colors.amber,
                          child: Text('$index'),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Visibility(
                visible: isShow,
                child: sub(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
