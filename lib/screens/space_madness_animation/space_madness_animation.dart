import 'package:animation/screens/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

//From transfrom + Stack + Animation = Complex UI
class SpaceMadnessAnimation extends StatefulWidget {
  const SpaceMadnessAnimation({super.key});

  @override
  State<SpaceMadnessAnimation> createState() => _SpaceMadnessAnimationState();
}

//Curve
//Interval
class _SpaceMadnessAnimationState extends State<SpaceMadnessAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController
      _controller; //AnimationController value runs from 0 to 1
  late final Animation<double> _rotateAnimation;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double>
      _scaleAnimation; //Animation value runs as how we customize
  late final Animation<double> _upDownAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 25));
    _setupScaleAndRotateAnimation();

    _setupUpDownAnimation();

    _setupOffsetAnimation();
    _controller.repeat(reverse: true);
  }

  void _setupScaleAndRotateAnimation() {
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.25),
      ),
    );

    _rotateAnimation =
        Tween<double>(begin: degreeToRadian(0), end: degreeToRadian(30))
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.1, 0.7),
      ),
    );
  }

  void _setupUpDownAnimation() {
    //5 times up
    //5 times down
    //5+5=10
    const totalUpDown = 2;
    const weight = 1 / totalUpDown;
    const double upDX = 10;
    final upTween = Tween<double>(begin: 0, end: upDX);
    final downTween = Tween<double>(begin: upDX, end: 0);
    _upDownAnimation = TweenSequence<double>([
      for (int i = 0; i < totalUpDown; i++) ...[
        TweenSequenceItem<double>(tween: upTween, weight: weight),
        TweenSequenceItem<double>(tween: downTween, weight: weight),
      ]
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.8),
      ),
    );
  }

  void _setupOffsetAnimation() {
    const dx = 15.0;
    const dy = 20.0;
    const goLeft = Offset(dx, 0);
    const goDown = Offset(dx, dy);
    const goRight = Offset(0, dy);
    const original = Offset.zero;
    _offsetAnimation = TweenSequence<Offset>(
      [
        TweenSequenceItem(
            tween: Tween(begin: original, end: goLeft), weight: 0.5),
        TweenSequenceItem(
            tween: Tween(begin: goLeft, end: goDown), weight: 0.25),
        TweenSequenceItem(
            tween: Tween(begin: goDown, end: goRight), weight: 0.125),
        TweenSequenceItem(
            tween: Tween(begin: goRight, end: original), weight: 0.125),
      ],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.25, 0.66),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); //DO Not forgot to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 400,
          width: 200,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, value) {
                      return Transform.translate(
                        offset: Offset(0, _upDownAnimation.value),
                        child: Transform.rotate(
                          angle: _rotateAnimation.value,
                          child: Transform.translate(
                            offset: _offsetAnimation.value,
                            child: Transform.scale(
                              scale: _scaleAnimation.value,
                              child: SvgPicture.asset(
                                ImageConstants.particles,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SvgPicture.asset(
                ImageConstants.trophy,
              ),
            ],
          ),
        ),
      ),
    );
  }

  double degreeToRadian(double degree) {
    return degree * ((22 / 7) / 180);
  }
}
