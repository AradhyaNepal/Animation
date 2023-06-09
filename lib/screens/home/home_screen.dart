import 'package:animation/screens/animation_background/animation_background_screen.dart';
import 'package:animation/screens/animation_background/animation_family_tree.dart';
import 'package:animation/screens/animation_background/without_animation_family_members.dart';
import 'package:animation/screens/home/widgets/home_screen_options_widgets.dart';
import 'package:animation/screens/terminologies/animation_curve_screen.dart';
import 'package:animation/screens/terminologies/animation_interval_screen.dart';
import 'package:animation/screens/terminologies/animation_with_ticker_and_family.dart';
import 'package:animation/screens/terminologies/animation_with_ticker_and_setstate.dart';
import 'package:animation/screens/terminologies/animation_without_animation_class.dart';
import 'package:animation/screens/terminologies/intrinsic_animation_screen.dart';
import 'package:animation/screens/terminologies/tween_screen_advance.dart';
import 'package:animation/screens/terminologies/tween_screen_basic.dart';
import 'package:flutter/material.dart';

import '../terminologies/animation_with_ticker_and_text_editing_controller.dart';

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
                HomeScreenOptionsWidget(
                  heading:  AnimationWithoutAnimationClass.title,
                  routeToNavigate: AnimationWithoutAnimationClass.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationWithTickerAndFamily.title,
                  routeToNavigate: AnimationWithTickerAndFamily.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationWithTickerAndSetState.title,
                  routeToNavigate: AnimationWithTickerAndSetState.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationWithTickerAndTextEditingController.title,
                  routeToNavigate: AnimationWithTickerAndTextEditingController.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  IntrinsicAnimationScreen.title,
                  routeToNavigate: IntrinsicAnimationScreen.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  TweenScreenBasic.title,
                  routeToNavigate: TweenScreenBasic.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  TweenScreenAdvance.title,
                  routeToNavigate: TweenScreenAdvance.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationCurveScreen.title,
                  routeToNavigate: AnimationCurveScreen.route,
                ),
                HomeScreenOptionsWidget(
                  heading:  AnimationIntervalScreen.title,
                  routeToNavigate: AnimationIntervalScreen.route,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
