import 'package:animation/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class AnimationBackgroundScreen extends StatefulWidget {
  static const String route="/animationBackgroundScreen";
  static const String title="Animation Background";
  const AnimationBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<AnimationBackgroundScreen> createState() => _AnimationBackgroundScreenState();
}

class _AnimationBackgroundScreenState extends State<AnimationBackgroundScreen> with SingleTickerProviderStateMixin{
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _animationController=AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3)
    );
    _animation=_animationController;
    _animationController.value=0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AnimationBackgroundScreen.title,
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
              onPressed: (){
                if(_animation.value<=0){
                  _animationController.value=1;
                }else{
                  _animationController.value=0;
                }
              },
              child: const Text(
                "Perform Animation"
              )
          ),
        ],
      ),
    );
  }
}


//Todo: Memory Leak
//Todo: Do the actual animation
