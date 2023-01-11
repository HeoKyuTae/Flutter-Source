import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isExtend = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Container(
        height: isExtend == false ? 100 : 200,
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
