import 'package:animation/screens/animation_background/animation_background_screen.dart';
import 'package:animation/screens/animation_background/animation_family_tree.dart';
import 'package:animation/screens/animation_background/without_animation_family_members.dart';
import 'package:animation/screens/home/home_screen.dart';
import 'package:animation/screens/space_madness_animation/space_madness_animation.dart';
import 'package:animation/screens/terminologies/animation_curve_screen.dart';
import 'package:animation/screens/terminologies/animation_interval_screen.dart';
import 'package:animation/screens/terminologies/animation_with_ticker_and_family.dart';
import 'package:animation/screens/terminologies/animation_with_ticker_and_setstate.dart';
import 'package:animation/screens/terminologies/animation_with_ticker_and_text_editing_controller.dart';
import 'package:animation/screens/terminologies/animation_without_animation_class.dart';
import 'package:animation/screens/terminologies/intrinsic_animation_screen.dart';
import 'package:animation/screens/terminologies/tween_screen_advance.dart';
import 'package:animation/screens/terminologies/tween_screen_basic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/driver_extension.dart';

void main() {
  enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
     home: SpaceMadnessAnimation(),
    );
  }
}
