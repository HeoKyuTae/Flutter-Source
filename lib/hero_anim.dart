import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({super.key});

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  String title = 'MY HEADER';
  String key = 'header';

  Route _createRoute(String title, String tag) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => HeroFirst(
        title: title,
        tagKey: key,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed(HeroFirst.routName);
              Navigator.push(
                context,
                _createRoute(title, key),
              );
            },
            child: Hero(
              tag: key,
              child: Text(
                title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeroFirst extends StatefulWidget {
  final String? title;
  final String? tagKey;
  const HeroFirst({super.key, this.title, this.tagKey});

  @override
  State<HeroFirst> createState() => _HeroFirstState();
}

class _HeroFirstState extends State<HeroFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Hero(
                tag: widget.tagKey!,
                child: Text(
                  widget.title!,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            )));
  }
}
