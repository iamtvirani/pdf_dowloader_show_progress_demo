import 'package:flutter/material.dart';

class Bouncing extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const Bouncing({super.key, required this.child, required this.onPressed});

  @override
  BouncingState createState() => BouncingState();
}

class BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  VoidCallback get onPressed => widget.onPressed ?? () {};

  @override
  void initState() {
    _animate = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - (_animate.value * 2.5);
    return GestureDetector(
      onTap: _onTap,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    _animate.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _animate.reverse();
      onPressed();
    });
  }
}
