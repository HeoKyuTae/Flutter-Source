import 'package:flutter/material.dart';

class TabItem2 extends StatefulWidget {
  const TabItem2({super.key});

  @override
  State<TabItem2> createState() => _TabItem2State();
}

class _TabItem2State extends State<TabItem2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int count = 50;

  @override
  void initState() {
    print('TabItem2 init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              height: 60,
              child: Text('$index'),
            ),
          );
        },
      ),
    );
  }
}
