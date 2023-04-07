import 'package:flutter/material.dart';

class ShimmerTemp extends StatelessWidget {
  final int idx;
  const ShimmerTemp({super.key, required this.idx});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Container(
            width: 100,
            padding: const EdgeInsets.all(4),
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5), borderRadius: BorderRadius.circular(16)),
            ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.grey.withOpacity(0.5),
                  child: Text('$idx'),
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 20,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Expanded(
                      child: Container(
                        height: 20,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
