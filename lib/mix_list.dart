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
    _listviewController.addListener(_addListListener1);
    generatorList();
    super.initState();
  }

  generatorList() {
    setState(() {
      list += 20;
    });
  }

  _addListListener() {
    // double maxScroll = _scrollController.position.maxScrollExtent;
    // double currentScroll = _scrollController.position.pixels;
    // double delta = 200.0; // or something else..
    // if (maxScroll - currentScroll <= delta) {
    //   generatorList();
    // }

    // setState(() {});

    print('_scrollController : ${_scrollController.offset}');

    if (_scrollController.offset > 400) {
      controller = false;
    } else {
      controller = true;
    }
    setState(() {});
  }

  _addListListener1() {
    print('_listviewController : ${_listviewController.offset}');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _listviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                  child: SingleChildScrollView(
                controller: _scrollController,
                physics: controller ? null : const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 400,
                      color: Colors.red,
                    ),
                    Container(
                      height: controller ? size.height - 48 : 0,
                      child: ListView.builder(
                        controller: _listviewController,
                        shrinkWrap: controller,
                        physics:
                            controller ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                        itemCount: 100,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 100,
                              color: Colors.amber,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
