import 'package:animation/screens/animation_background/animation_background_screen.dart';
import 'package:animation/screens/animation_background/animation_family_tree.dart';
import 'package:animation/screens/animation_background/without_animation_family_members.dart';
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SizedBox(height: 50,),
                HomeScreenOptionsWidget(
                  heading:  AnimationBackgroundScreen.title,
                  routeToNavigate: AnimationBackgroundScreen.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  WithoutFamilyMembersOfAnimation.title,
                  routeToNavigate: WithoutFamilyMembersOfAnimation.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationFamilyTree.title,
                  routeToNavigate: AnimationFamilyTree.route,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
