// ignore_for_file: prefer_conditional_assignment

import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationWithTickerAndSetState extends StatefulWidget {
  static const String route="/AnimationWithTickerAndSetState";
  static const String title="Animation With Ticker And Set State";
  const AnimationWithTickerAndSetState({Key? key}) : super(key: key);

  @override
  State<AnimationWithTickerAndSetState> createState() => _AnimationWithTickerAndSetStateState();
}

class _AnimationWithTickerAndSetStateState extends State<AnimationWithTickerAndSetState> with TickerProviderStateMixin{
  final int _durationInSecond=3;
  double value=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AnimationWithTickerAndSetState.title,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomLoading(
            progressMultiple: value,
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
    if(value<=0){
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
        value=1-1*_percentageOfProgress(deltaTime);
        if(value<=0)_backwardTicker?.stop();
        setState(() {});
      });
    }
    _backwardTicker?.start();
  }


  void _forwardAnimation() {
    if(_forwardTicker==null){
      _forwardTicker=createTicker((deltaTime) {
        value=1*_percentageOfProgress(deltaTime);
        if(value>=1)_forwardTicker?.stop();
        setState(() {});
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
