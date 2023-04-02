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
  late final Animation<Color> _colorAnimation;

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
    _setOffSetAnimation();
    super.didChangeDependencies();
  }

  //Tween .animate(controller)
  void _setSizeAnimation() {
    _sizeAnimation=Tween<double>(begin: 1,end: 2).animate(_controller);
  }


  //Controller .drive(Tween)
  void _setOffSetAnimation() {
    final size=MediaQuery.of(context).size;
    _offsetAnimation=_colorAnimation.drive(
      Tween<Offset>(begin: const Offset(0,0),end: Offset(size.width,size.height))
    );
  }


  //My Personal Choice
  void _setColorAnimation(){
    _colorAnimation=Tween<Color>(begin: Colors.red,end: Colors.green).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
