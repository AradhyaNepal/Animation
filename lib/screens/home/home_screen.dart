import 'package:animation/screens/animation_background/animation_background_screen1.dart';
import 'package:animation/screens/home/widgets/home_screen_options_widgets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String route="/";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
          ),
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                HomeScreenOptionsWidget(
                  heading:  AnimationBackgroundScreen1.title,
                  routeToNavigate: AnimationBackgroundScreen1.route,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
