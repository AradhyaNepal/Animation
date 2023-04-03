import 'dart:async';

import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class AnimationWithoutAnimationClass extends StatefulWidget {
  static const String route="/AnimationWithoutAnimationClass";
  static const String title="Animation Without Animation Class";
  const AnimationWithoutAnimationClass({Key? key}) : super(key: key);

  @override
  State<AnimationWithoutAnimationClass> createState() => _AnimationWithoutAnimationClassState();
}

class _AnimationWithoutAnimationClassState extends State<AnimationWithoutAnimationClass> {
  final int _durationInSecond=5;
  final ValueNotifier<double> _animation=ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AnimationWithoutAnimationClass.title,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (_,__){
                return CustomLoading(
                  progressMultiple: _animation.value,
                );
              }
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: _customAnimation,
              child: const Text(
                  "Perform Animation"
              )
          ),
        ],
      ),
    );
  }

  void _customAnimation() {
    if(timer!=null && timer!.isActive)return;
    if(_animation.value<=0){
      _forwardAnimation();
    }else{
      _backwardAnimation();
    }
  }

  Timer? timer;
  void _backwardAnimation() {
    timer=Timer.periodic(_durationToUpdate, (timer) {
      _animation.value=_animation.value-_amountToUpdate;
      if(_animation.value<=0){
        timer.cancel();
      }
    });
  }


  void _forwardAnimation() {
    timer=Timer.periodic(_durationToUpdate, (timer) {
      _animation.value=_animation.value+_amountToUpdate;
      if(_animation.value>=1){
        timer.cancel();
      }
    });
  }

  double get _amountToUpdate{
    return 1/_totalTimesAmountGetUpdated;
  }

  double get _totalTimesAmountGetUpdated => (_durationInSecond*1000)/_durationToUpdate.inMilliseconds;
  Duration get _durationToUpdate => const Duration(milliseconds: 250);

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
