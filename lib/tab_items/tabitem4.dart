import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabItem4 extends StatefulWidget {
  const TabItem4({super.key});

  @override
  State<TabItem4> createState() => _TabItem4State();
}

class _TabItem4State extends State<TabItem4> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('TabItem4 init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
    );
  }
}
