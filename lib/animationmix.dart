import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AnimationMix extends StatefulWidget {
  const AnimationMix({super.key});

  @override
  State<AnimationMix> createState() => _AnimationMixState();
}

class _AnimationMixState extends State<AnimationMix> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 100,
                decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    AnimatedContainer(
                      width: isShow ? 0 : 20,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        height: 5,
                        color: Colors.black,
                      ),
                    ),
                    AnimatedOpacity(
                      opacity: isShow ? 0 : 1,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        width: 250,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    print('object');
                    setState(() {
                      isShow = !isShow;
                    });
                  },
                  child: const Text('press')),
            )
          ],
        ),
      ),
    );
  }
}
