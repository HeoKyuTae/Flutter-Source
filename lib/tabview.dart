import 'package:flutter/material.dart';
import 'package:make_source/notification_center/notification_center.dart';
import 'package:make_source/tab_items/tabitem1.dart';
import 'package:make_source/tab_items/tabitem2.dart';
import 'package:make_source/tab_items/tabitem3.dart';
import 'package:make_source/tab_items/tabitem4.dart';
import 'package:make_source/tab_items/tabitem_blank.dart';

class BottomTabView extends StatefulWidget {
  const BottomTabView({super.key});

  @override
  State<BottomTabView> createState() => _BottomTabViewState();
}

class _BottomTabViewState extends State<BottomTabView> with TickerProviderStateMixin {
  late TabController _tabController;
  var tabItems = const [
    TabItem1(),
    TabItem2(),
    TabItemBlank(),
    TabItem3(),
    TabItem4(),
  ];

  int isSelect = 0;

  @override
  void initState() {
    _tabController = TabController(length: tabItems.length, vsync: this);
    setNotification();

    super.initState();
  }

  setNotification() {
    NotificationCenter().subscribe('tabitem1', () {
      setState(() {
        _tabController.index = 0;
      });
    });

    NotificationCenter().subscribe('tabitem2', () {
      setState(() {
        _tabController.index = 1;
      });
    });

    NotificationCenter().subscribe('tabitem3', () {
      setState(() {
        _tabController.index = 3;
      });
    });

    NotificationCenter().subscribe('tabitem4', () {
      setState(() {
        _tabController.index = 4;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                color: Colors.red,
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(), controller: _tabController, children: tabItems),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 0.1,
                      blurRadius: 15,
                      offset: const Offset(0, -15),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                  child: TabBar(
                    indicatorColor: Colors.transparent,
                    // indicatorColor: const Color.fromRGBO(184, 99, 154, 1),
                    isScrollable: false,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    controller: _tabController,
                    onTap: (value) {
                      print(value);
                      if (value == 2) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Snack'),
                          ),
                        );
                        setState(() {
                          _tabController.index = isSelect;
                        });
                      } else {
                        setState(() {
                          isSelect = value;
                        });
                      }
                    },
                    tabs: [
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.abc),
                            Text(
                              '홈',
                              style: const TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.abc),
                            Text(
                              '클로젯',
                              style: const TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              size: 44,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.abc),
                            Text(
                              '채널',
                              style: const TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.abc),
                            Text(
                              '마이페이지',
                              style: const TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
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
