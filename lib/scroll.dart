import 'package:flutter/material.dart';
import 'package:make_source/category.dart';
import 'package:make_source/header.dart';
import 'package:make_source/profile.dart';

class MultiScroll extends StatefulWidget {
  const MultiScroll({super.key});

  @override
  State<MultiScroll> createState() => _MultiScrollState();
}

class _MultiScrollState extends State<MultiScroll> {
  final ScrollController _scrollController = ScrollController();

  double isScroll = 0;

  @override
  void initState() {
    _scrollController.addListener(scrollListner);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  scrollListner() {
    setState(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print('bottom');
      }

      isScroll = _scrollController.offset;
      print(isScroll);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              const Header(),
              Expanded(
                  child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        const Profile(),
                        const Category(),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 100,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 60,
                                child: Card(
                                  color: Colors.blueAccent[50],
                                  child: Text('$index'),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                  isScroll > 200 ? const Category() : Container()
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
