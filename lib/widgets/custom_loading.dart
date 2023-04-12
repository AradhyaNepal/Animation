

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final double progressMultiple;
  final Color color;
  const CustomLoading({this.color=Colors.blue,required this.progressMultiple,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width,
      child: CustomPaint(
        painter: LoadingCustomPainter(
          progressMultiple: progressMultiple,
          color: color,
        ),
      ),
    );
  }
}

class LoadingCustomPainter extends CustomPainter{
  Color color;
  double progressMultiple;
  LoadingCustomPainter({required this.progressMultiple,required this.color}) {
    if(progressMultiple<=0){
      progressMultiple=0;
    }else if(progressMultiple>=1){
      progressMultiple=1;
    }
  }



  @override
  void paint(Canvas canvas, Size size) {
    _drawBackground(canvas, size);
    _drawProgress(canvas, size);
    _drawInnerDot(canvas,size);

  }

  void _drawBackground(Canvas canvas, Size size) {
    Paint paint=Paint()..color=color.withOpacity(0.4)..style=PaintingStyle.fill..strokeWidth=size.height..strokeCap=StrokeCap.round;
    canvas.drawLine(Offset(_startPosition(size), 0), Offset(endWidth(size), 0), paint);
  }

  double _startPosition(Size size) => size.width*0.05;

  void _drawProgress(Canvas canvas, Size size) {
    if(progressMultiple>=0.04){
       Paint paint=Paint()..color=color..style=PaintingStyle.fill..strokeWidth=size.height..strokeCap=StrokeCap.round;
      canvas.drawLine(Offset(_startPosition(size), 0), Offset(_animationEnd(size), 0), paint);
    }
  }

  double _animationEnd(Size size) => endWidth(size)*progressMultiple;

  void _drawInnerDot(Canvas canvas, Size size) {
    for(double i =_startPosition(size);i<_animationEnd(size)-_widthPerItem(size);i+=_widthPerItem(size)){
      Paint paint=Paint()..color=Colors.white..style=PaintingStyle.fill..strokeWidth=size.height/5..strokeCap=StrokeCap.round;
      canvas.drawLine(Offset(i+_widthPerItem(size)/2, 0), Offset(i+_widthPerItem(size)/2, 0), paint);
    }
  }

  double _widthPerItem(Size size) => endWidth(size)/_numberOfItem();

  int _numberOfItem() => 15;

  double endWidth(Size size) => size.width*0.95;

  @override
  bool shouldRepaint(covariant LoadingCustomPainter oldDelegate) {
    return oldDelegate.progressMultiple !=progressMultiple;
  }

}