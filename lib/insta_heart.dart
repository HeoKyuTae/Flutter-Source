import 'package:flutter/material.dart';

class InstaHeart extends StatefulWidget {
  const InstaHeart({super.key});

  @override
  State<InstaHeart> createState() => _InstaHeartState();
}

class _InstaHeartState extends State<InstaHeart> {
  List<FavIconData> favIconDatas = [];

  void addFavIcon(int timestamp) {
    favIconDatas.add(FavIconData(timestamp));
  }

  void _onTap() {
    setState(() {
      addFavIcon(DateTime.now().millisecondsSinceEpoch);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black,
          child: SizedBox.expand(
            child: Center(
              child: SizedBox.square(
                dimension: 56,
                child: Stack(
                  children: [
                    Stack(
                      children: favIconDatas
                          .map((e) => Positioned(
                                right: 16,
                                bottom: 16,
                                child: FavIconAnimator(
                                  onAnimationFinished: () {
                                    print('call');
                                    setState(() {
                                      if (favIconDatas.isNotEmpty) {
                                        favIconDatas.removeAt(0);
                                      }
                                    });
                                  },
                                ),
                              ))
                          .toList(),
                    ),
                    GestureDetector(
                      onTap: _onTap,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white30,
                        ),
                        child: const Icon(
                          Icons.favorite_outline,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FavIconData {
  int timestamp;
  FavIconData(this.timestamp);
}

class FavIconAnimator extends StatefulWidget {
  final VoidCallback onAnimationFinished;

  const FavIconAnimator({
    required this.onAnimationFinished,
    Key? key,
  }) : super(key: key);

  @override
  State<FavIconAnimator> createState() => _FavIconAnimatorState();
}

class _FavIconAnimatorState extends State<FavIconAnimator> with TickerProviderStateMixin {
  late AnimationController animation;

  @override
  void initState() {
    animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..forward();
    animation.addListener(_addListener);

    super.initState();
  }

  _addListener() {
    if (animation.status == AnimationStatus.completed) {
      print(animation.status);
      widget.onAnimationFinished();
      animation.reset();
    }
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value * -100),
          child: child,
        );
      },
      child: Icon(
        Icons.favorite,
        color: Colors.red[300],
      ),
    );
  }
}
