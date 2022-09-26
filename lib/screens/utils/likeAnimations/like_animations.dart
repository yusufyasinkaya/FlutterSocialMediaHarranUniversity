import 'package:flutter/material.dart';

class LikeAnimations extends StatefulWidget {
  final Widget child;
  final bool isAnimating;
  final Duration duration;
  final VoidCallback? onEnd;
  final bool smallLike;
  const LikeAnimations(
      {Key? key,
      required this.child,
      required this.isAnimating,
      this.duration = const Duration(microseconds: 150),
      this.onEnd,
      this.smallLike = false})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _LikeAnimations();
}

class _LikeAnimations extends State<LikeAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scale;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this,
        duration: Duration(microseconds: widget.duration.inMilliseconds ~/ 2));
    scale = Tween<double>(begin: 1, end: 1.2).animate(animationController);
  }

  @override
  void didUpdateWidget(covariant LikeAnimations oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating == oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await animationController.forward();
      await animationController.reverse();
      await Future.delayed(const Duration(microseconds: 200));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
