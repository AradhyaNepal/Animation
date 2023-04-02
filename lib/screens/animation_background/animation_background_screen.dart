import 'package:animation/screens/animation_background/widgets/custom_loading.dart';
import 'package:flutter/material.dart';

class AnimationBackgroundScreen extends StatefulWidget {
  static const String route="/animationBackgroundScreen";
  static const String title="Animation Background";
  const AnimationBackgroundScreen({Key? key}) : super(key: key);

  @override
  State<AnimationBackgroundScreen> createState() => _AnimationBackgroundScreenState();
}

class _AnimationBackgroundScreenState extends State<AnimationBackgroundScreen> with SingleTickerProviderStateMixin{
  late final AnimationController animationController;
  late final Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController=AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1)
    );
    animation=animationController.view;
    animationController.value=0;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: animation,
              builder: (_,__){
                return CustomLoading(
                  progressMultiple: animation.value,
                );
              }
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                if(animation.value<=0){
                  animationController.value=1;
                }else{
                  animationController.value=0;
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

