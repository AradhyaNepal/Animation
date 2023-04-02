import 'package:flutter/material.dart';

class HomeScreenOptionsWidget extends StatelessWidget {
  final String heading;
  final String routeToNavigate;

  const HomeScreenOptionsWidget({
    required this.heading,
    required this.routeToNavigate,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeToNavigate);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
          ),
          child: Text(
            heading,
          ),
        ),
      ),
    );
  }
}
