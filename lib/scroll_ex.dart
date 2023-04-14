import 'package:flutter/material.dart';

class ScrollEX extends StatefulWidget {
  const ScrollEX({super.key});

  @override
  State<ScrollEX> createState() => _ScrollEXState();
}

class _ScrollEXState extends State<ScrollEX> with SingleTickerProviderStateMixin {
  late TabController tabController;

  final List<Tab> _tabs = [
    const Tab(text: '스타일'), //스타일
    const Tab(text: '아이템'), //아이템
    const Tab(text: '채널') //채널
  ];

  int isSelect = 0;

  itemTabs(int idx) {
    switch (idx) {
      case 0:
        return SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
            childAspectRatio: 0.73, //item 의 가로 1, 세로 2 의 비율
            mainAxisSpacing: 10, //수평 Padding
            crossAxisSpacing: 10, //수직 Padding
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.red,
            );
          },
          // delegate: SliverChildListDelegate(
          //   List.generate(
          //     1,
          //     (index) => Card(
          //       color: Colors.teal[100 * (index % 9)],
          //       child: Container(
          //         padding: const EdgeInsets.all(20),
          //         child: Text('Tab1 $index'),
          //       ),
          //     ),
          //   ),
          // ),
        );
      case 1:
        return SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              10,
              (index) => Card(
                color: Colors.teal[100 * (index % 9)],
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('Tab2 $index'),
                ),
              ),
            ),
          ),
        );
      case 2:
        return SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              50,
              (index) => Card(
                color: Colors.teal[100 * (index % 9)],
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text('Tab3 $index'),
                ),
              ),
            ),
          ),
        );
      default:
    }
  }

  @override
  void initState() {
    tabController = TabController(
      length: _tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 48,
              color: Colors.red,
            ),
            Expanded(
              child: DefaultTabController(
                length: _tabs.length,
                initialIndex: isSelect,
                child: CustomScrollView(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: Profile(),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverTabBarViewDelegate(
                        child: Container(
                            color: Theme.of(context).cardColor,
                            child: TabBar(
                              labelColor: Colors.black,
                              labelStyle: TextStyle(fontSize: 15),
                              unselectedLabelColor: Colors.grey,
                              unselectedLabelStyle: TextStyle(fontSize: 15),
                              indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(173, 106, 153, 1),
                                  width: 0.5,
                                ),
                              ),
                              controller: tabController,
                              tabs: _tabs,
                              onTap: (value) {
                                setState(() {
                                  isSelect = value;
                                });
                              },
                            )),
                      ),
                    ),
                    itemTabs(isSelect)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverTabBarViewDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarViewDelegate({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: child,
      elevation: 200,
    );
  }

  @override
  double get maxExtent => kTextTabBarHeight;

  @override
  double get minExtent => kTextTabBarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

// class TabBarDelegate extends SliverPersistentHeaderDelegate {
//   const TabBarDelegate();

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       color: const Color.fromARGB(255, 240, 240, 240),
//       child: TabBar(
//         tabs: [
//           Tab(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: const Text(
//                 "홈",
//               ),
//             ),
//           ),
//           Tab(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: const Text(
//                 "특가",
//               ),
//             ),
//           ),
//           Tab(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8),
//               child: const Text(
//                 "랭킹",
//               ),
//             ),
//           ),
//         ],
//         indicatorWeight: 2,
//         padding: const EdgeInsets.symmetric(horizontal: 16.0),
//         unselectedLabelColor: Colors.grey,
//         labelColor: Colors.black,
//         indicatorColor: Colors.black,
//         indicatorSize: TabBarIndicatorSize.label,
//         onTap: (value) {},
//       ),
//     );
//   }

//   @override
//   double get maxExtent => 48;

//   @override
//   double get minExtent => 48;

//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
//     return false;
//   }
// }

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1000,
      color: Colors.amber,
    );
  }
}
