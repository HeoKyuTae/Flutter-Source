import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SliverL extends StatefulWidget {
  const SliverL({super.key});

  @override
  State<SliverL> createState() => _SliverLState();
}

class _SliverLState extends State<SliverL> with TickerProviderStateMixin {
  late TabController _tabController;
  int count = 100;
  int tab = 0;

  _categoryView(int idx) {
    switch (idx) {
      case 0:
        return Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            color: const Color.fromARGB(255, 250, 250, 250),
            height: 44,
            child: const Text('index 1'));
      case 1:
        return Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            color: const Color.fromARGB(255, 250, 250, 250),
            height: 44,
            child: const Text('index 2'));
      case 2:
        return Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
            color: const Color.fromARGB(255, 250, 250, 250),
            height: 44,
            child: const Text('index 3'));
    }
  }

  final List<Tab> _tabs = [
    const Tab(text: 'title_tap_style'), //스타일
    const Tab(text: 'title_tap_item'), //아이템
    const Tab(text: 'bottomBar_channel') //채널
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverToBoxAdapter(
                    child: Container(
                      height: 300,
                      color: Colors.red,
                    ),
                  ),
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 0,
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white,
                    bottom: TabBar(
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 13),
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: TextStyle(fontSize: 13),
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(173, 106, 153, 1),
                          width: 0.5,
                        ),
                      ),
                      controller: _tabController,
                      tabs: _tabs,
                      onTap: (value) {
                        setState(() {
                          tab = value;
                        });
                      },
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverTabBarViewDelegate(
                      widget: _categoryView(tab),
                    ),
                  ),
                ];
              },
              body: NotificationListener(
                onNotification: (notification) {
                  print(notification);
                  return true;
                },
                child: ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      color: Colors.green,
                      child: Text('$index'),
                    );
                  },
                ),
              )),
        ),
      ),
    );
  }
}

class _SliverTabBarViewDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;

  _SliverTabBarViewDelegate({
    required this.widget,
  });

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => 44;

  @override
  double get minExtent => 44;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
