import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabItem2 extends StatefulWidget {
  const TabItem2({super.key});

  @override
  State<TabItem2> createState() => _TabItem2State();
}

class _TabItem2State extends State<TabItem2> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('TabItem2 init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }
}
