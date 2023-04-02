// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class TweenScreenBasic extends StatefulWidget {
  static const String route="/TweenScreenBasic";
  static const String title="Tween Screen Basic";
  const TweenScreenBasic({Key? key}) : super(key: key);

  @override
  State<TweenScreenBasic> createState() => _TweenScreenBasicState();
}

class _TweenScreenBasicState extends State<TweenScreenBasic> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _sizeAnimation;
  late final Animation<Color?> _colorAnimation;
  late final Size _size;
  @override
  void initState() {
    _controller=AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500)
    );
    _setSizeAnimation();
    _setColorAnimation();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _size=MediaQuery.of(context).size;
    _setOffSetAnimation();
    super.didChangeDependencies();
  }

  //Tween .animate(controller)
  void _setSizeAnimation() {
    _sizeAnimation=Tween<double>(begin: 1,end: 2).animate(_controller);
  }


  //Controller .drive(Tween)
  void _setOffSetAnimation() {
    _offsetAnimation=_controller.drive(
      Tween<Offset>(begin: const Offset(0,0),end: Offset(_size.width*0.8,_size.height*0.8))
    );
  }

  void _setColorAnimation(){
    _colorAnimation=ColorTween(begin: Colors.red,end: Colors.orange).animate(_controller);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TweenScreenBasic.title,
        ),
        actions: [
          IconButton(
            onPressed: (){
              _controller.reset();
            },
            icon: const Icon(Icons.lock_reset_sharp)
          ),
          IconButton(
              onPressed: (){
                _controller.stop();
              },
              icon: const Icon(Icons.stop),
          ),
        ],
      ),
      body: GestureDetector(
        onLongPress: _animateLongPress,
        onDoubleTap: _animateDoubleTap,
        onTap: _animateTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context,child) {
            return Transform.translate(
              offset: _offsetAnimation.value,
              child: Transform.scale(
                scale: _sizeAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    shape: BoxShape.circle,
                  ),
                  height: 50,
                  width: 50,
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  bool get _isNotAnimating => !_controller.isAnimating;

  void _animateLongPress() async {
    if (_isNotAnimating) {
      _controller.repeat(reverse: true);
      _controller.repeat(reverse: true);
    }
  }


  void _animateDoubleTap()async{
    if(_isNotAnimating){
      _controller.repeat();
    }
  }

  void _animateTap()async{
    if(_isNotAnimating){
      await _controller.forward();
      await _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
