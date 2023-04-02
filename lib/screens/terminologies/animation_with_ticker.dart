// ignore_for_file: prefer_conditional_assignment

import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationWithTicker extends StatefulWidget {
  static const String route="/AnimationWithTicker";
  static const String title="Animation With Ticker";
  const AnimationWithTicker({Key? key}) : super(key: key);

  @override
  State<AnimationWithTicker> createState() => _AnimationWithTickerState();
}

class _AnimationWithTickerState extends State<AnimationWithTicker> with TickerProviderStateMixin{
  final int _durationInSecond=5;
  final ValueNotifier<double> _animation=ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AnimationWithTicker.title,
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
    if(_forwardTicker!=null && _forwardTicker!.isTicking)return;
    if(_animation.value<=0){
      _forwardAnimation();
    }else{
      _backwardAnimation();
    }
  }

  Ticker? _forwardTicker;
  Ticker? _backwardTicker;
  void _backwardAnimation() {
    if(_backwardTicker==null){
      _backwardTicker=createTicker((deltaTime) {
        _animation.value=1-1*_percentageOfProgress(deltaTime);
        if(_animation.value<=0)_backwardTicker?.stop();
      });
    }
    _backwardTicker?.start();
  }


  void _forwardAnimation() {
    if(_forwardTicker==null){
      _forwardTicker=createTicker((deltaTime) {
        _animation.value=1*_percentageOfProgress(deltaTime);
        if(_animation.value>=1)_forwardTicker?.stop();
      });
    }
    _forwardTicker?.start();
  }

  double _percentageOfProgress(Duration deltaTime) => deltaTime.inMilliseconds/(_durationInSecond*1000);





  @override
  void dispose() {
    _forwardTicker?.dispose();
    _backwardTicker?.dispose();
    super.dispose();
  }
}
