import 'package:flutter/material.dart';

class Blend extends StatefulWidget {
  const Blend({super.key});

  @override
  State<Blend> createState() => _BlendState();
}

class _BlendState extends State<Blend> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'images/t1.png',
          ),
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.srcOut),
            child: Container(
              width: size.width,
              height: size.width,
              decoration: BoxDecoration(
                color: Colors.black87,
                border: Border.all(),
                borderRadius: BorderRadius.circular(500),
                // backgroundBlendMode: BlendMode.clear,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1000,
                    blurRadius: 1,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
