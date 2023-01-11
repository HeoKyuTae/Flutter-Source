import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Tenkey extends StatefulWidget {
  const Tenkey({super.key});

  @override
  State<Tenkey> createState() => _TenkeyState();
}

class _TenkeyState extends State<Tenkey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                maxLength: 15,
                decoration: InputDecoration(
                  hintText: 'TextField',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w100),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'TextFormField',
                  hintStyle: const TextStyle(fontWeight: FontWeight.w100),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
