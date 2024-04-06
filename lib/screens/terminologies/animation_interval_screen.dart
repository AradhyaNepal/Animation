import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class AnimationIntervalScreen extends StatefulWidget {
  static const String route = "/AnimationIntervalScreen";
  static const String title = "Animation Interval Screen";

  const AnimationIntervalScreen({Key? key}) : super(key: key);

  @override
  State<AnimationIntervalScreen> createState() =>
      _AnimationIntervalScreenState();
}

class _AnimationIntervalScreenState extends State<AnimationIntervalScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _progressAnimation;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _setProgressAnimation();
    _setColorAnimation();
  }

  final Curve _curve = Curves.easeInOut;

  void _setProgressAnimation() {
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: _curve,
      ),
    );
  }

  void _setColorAnimation() {
    _colorAnimation = ColorTween(begin: Colors.red, end: Colors.orange).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.4,
          0.6
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    color: _colorAnimation.value,
                    child: child ?? const SizedBox(),
                  );
                },
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(
                      child: Text(
                        AnimationIntervalScreen.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    return Column(
                      children: [
                        CustomLoading(
                          color: _colorAnimation.value ?? Colors.blue,
                          progressMultiple: _progressAnimation.value,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: _colorAnimation.value),
                            onPressed: _animate,
                            child: const Text("Perform Animation")),
                      ],
                    );
                  }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void _animate() async {
    if (!_controller.isAnimating) {
      if (_progressAnimation.value <= 0) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
