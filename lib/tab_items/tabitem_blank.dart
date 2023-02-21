import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TabItemBlank extends StatefulWidget {
  const TabItemBlank({super.key});

  @override
  State<TabItemBlank> createState() => _TabItemBlankState();
}

class _TabItemBlankState extends State<TabItemBlank> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    print('TabItemBlank init');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
    );
  }
}
