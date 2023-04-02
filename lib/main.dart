import 'package:animation/screens/animation_background/animation_background_screen.dart';
import 'package:animation/screens/animation_background/animation_family_tree.dart';
import 'package:animation/screens/animation_background/without_animation_family_members.dart';
import 'package:animation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
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
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route:(_)=>const HomeScreen(),
        AnimationFamilyTree.route:(_)=>const AnimationFamilyTree(),
        WithoutFamilyMembersOfAnimation.route:(_)=>const WithoutFamilyMembersOfAnimation(),
        AnimationBackgroundScreen.route:(_)=>const AnimationBackgroundScreen(),
      },
    );
  }
}
