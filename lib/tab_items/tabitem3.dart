import 'package:flutter/material.dart';

class TabItem3 extends StatefulWidget {
  const TabItem3({super.key});

  @override
  State<TabItem3> createState() => _TabItem3State();
}

class _TabItem3State extends State<TabItem3> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('TabItem3 init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
