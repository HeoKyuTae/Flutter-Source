import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabItem1 extends StatefulWidget {
  const TabItem1({super.key});

  @override
  State<TabItem1> createState() => _TabItem1State();
}

class _TabItem1State extends State<TabItem1> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('TabItem1 init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}
