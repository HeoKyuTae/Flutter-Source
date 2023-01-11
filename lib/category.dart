import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isExtend = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Container(
        height: isExtend == false ? 200 : 300,
        child: Center(
          child: TextButton(
              onPressed: () {
                print('object');
                setState(() {
                  isExtend = !isExtend;
                });
              },
              child: const Text('버튼')),
        ),
      ),
    );
  }
}
