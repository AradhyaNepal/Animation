import 'package:flutter/material.dart';

class TweenScreenAdvance extends StatefulWidget {
  static const String route="/TweenScreenAdvance";
  static const String title="Tween Screen Advance";
  const TweenScreenAdvance({Key? key}) : super(key: key);

  @override
  State<TweenScreenAdvance> createState() => _TweenScreenAdvanceState();
}

class _TweenScreenAdvanceState extends State<TweenScreenAdvance> with SingleTickerProviderStateMixin{
  late final AnimationController _controller;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _sizeAnimation;
  late final Animation<Color?> _colorAnimation;
  late final Size _size;
  @override
  void initState() {
    _controller=AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1500*4)
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
    _sizeAnimation=TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1,end: 2),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 2,end: 0.5),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.5,end: 3),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 3,end: 1),
        weight: 0.25,
      ),
    ]).animate(_controller);
  }


  //Controller .drive(Tween)
  void _setOffSetAnimation() {
    _offsetAnimation=_controller.drive(
      TweenSequence([
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: const Offset(0,0),
            end: Offset(_size.width*0.8,_size.height*0.05),
          ),
          weight: 0.25,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(_size.width*0.8,_size.height*0.05),
            end: Offset(_size.width*0.8,_size.height*0.8),
          ),
          weight:  0.25,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(_size.width*0.8,_size.height*0.8),
            end: Offset(_size.width*0.15,_size.height*0.75),
          ),
          weight:  0.25,
        ),
        TweenSequenceItem(
          tween: Tween<Offset>(
            begin: Offset(_size.width*0.15,_size.height*0.75),
            end: const Offset(0,0),
          ),
          weight:  0.25,
        ),
      ]),
    );
  }

  void _setColorAnimation(){
    _colorAnimation=TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red,end: Colors.purple),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.purple,end: Colors.green),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.green,end: Colors.blue),
        weight: 0.25,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.blue,end: Colors.red),
        weight: 0.25,
      ),
    ]).animate(_controller);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TweenScreenAdvance.title,
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

  void _animateTap()async{
    if(_isNotAnimating){
      await _controller.forward();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
