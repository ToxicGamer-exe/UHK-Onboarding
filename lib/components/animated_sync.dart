import 'package:flutter/material.dart';

class AnimatedSync extends AnimatedWidget {
  final VoidCallback callback;

  AnimatedSync(
      {Key? key, required Animation<double> animation, required this.callback})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Transform.rotate(
      angle: animation.value,
      child: Transform.flip(
        flipX: true,
        child: IconButton(
            icon: const Icon(Icons.sync), // <-- Icon
            onPressed: () => callback()),
      ),
    );
  }
}
