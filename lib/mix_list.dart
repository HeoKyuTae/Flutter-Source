import 'package:flutter/material.dart';

class MixList extends StatefulWidget {
  const MixList({super.key});

  @override
  State<MixList> createState() => _MixListState();
}

class _MixListState extends State<MixList> {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _listviewController = ScrollController();
  bool controller = true;

  int list = 0;

  @override
  void initState() {
    _scrollController.addListener(_addListListener);
    _listviewController.addListener(_addListListener);
    generatorList();
    super.initState();
  }

  generatorList() {
    setState(() {
      list += 20;
    });
  }

  _addListListener() {
    if (0.0 <= _listviewController.offset) {
      if (_scrollController.offset >= 400) {
        controller = false;
        _scrollController.jumpTo(444);

        double maxScroll = _listviewController.position.maxScrollExtent;
        double currentScroll = _listviewController.position.pixels;
        double delta = 200.0; // or something else..
        if (maxScroll - currentScroll <= delta) {
          generatorList();
        }
      }
    } else {
      controller = true;
      _scrollController.jumpTo(0);
    }

    print(controller);
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listviewController.dispose();
    super.dispose();
  }

  Widget tabbar() {
    return Container(
      height: 44,
      color: Colors.green,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var top = MediaQuery.of(context).viewPadding.top;
    var bottom = MediaQuery.of(context).viewPadding.bottom;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 44,
                color: Colors.amber,
                child: const Text('TEXT'),
              ),
              Expanded(
                  child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    physics: controller ? null : const NeverScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('object');
                          },
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            height: 400,
                            color: Colors.red,
                            child: Column(
                              children: [
                                Text('RED'),
                              ],
                            ),
                          ),
                        ),
                        tabbar(),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: size.height - (44 + top + bottom)),
                          child: ListView.builder(
                            controller: _listviewController,
                            shrinkWrap: controller,
                            physics: controller ? const NeverScrollableScrollPhysics() : null,
                            itemCount: list,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 100,
                                  color: Colors.amber,
                                  child: Text('$index'),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(visible: !controller, child: tabbar())
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
