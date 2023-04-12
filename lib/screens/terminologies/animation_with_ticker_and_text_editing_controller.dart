// ignore_for_file: prefer_conditional_assignment

import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AnimationWithTickerAndTextEditingController extends StatefulWidget {
  static const String route="/AnimationWithTickerAndTextEditingController";
  static const String title="Animation With Ticker And Text Editing Controller";
  const AnimationWithTickerAndTextEditingController({Key? key}) : super(key: key);

  @override
  State<AnimationWithTickerAndTextEditingController> createState() => _AnimationWithTickerAndTextEditingControllerState();
}

class _AnimationWithTickerAndTextEditingControllerState extends State<AnimationWithTickerAndTextEditingController> with TickerProviderStateMixin{
  final int _durationInSecond=3;
  final TextEditingController _animation=TextEditingController(text: "0");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AnimationWithTickerAndTextEditingController.title,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _animation,
              builder: (_,__){
                return CustomLoading(
                  progressMultiple: double.parse(_animation.text),
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
    if(double.parse(_animation.text)<=0){
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
        _animation.text=(1-1*_percentageOfProgress(deltaTime)).toString();
        if(double.parse(_animation.text)<=0)_backwardTicker?.stop();
      });
    }
    _backwardTicker?.start();
  }


  void _forwardAnimation() {
    if(_forwardTicker==null){
      _forwardTicker=createTicker((deltaTime) {
        _animation.text=(1*_percentageOfProgress(deltaTime)).toString();
        if(double.parse(_animation.text)>=1)_forwardTicker?.stop();
      });
    }
    _forwardTicker?.start();
  }

  double _percentageOfProgress(Duration deltaTime) => deltaTime.inMilliseconds/(_durationInSecond*1000);





  @override
  void dispose() {
    _forwardTicker?.dispose();
    _backwardTicker?.dispose();
    _animation.dispose();
    super.dispose();
  }
}
