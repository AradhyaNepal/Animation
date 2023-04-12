
import 'package:flutter/material.dart';

class LagIndicationWidget extends StatelessWidget {
  const LagIndicationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 10),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: const [
            SizedBox(
              height: 20,
            ),
            Text(
              "Lag Indicator",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FittedBox(
              child: CircularProgressIndicator(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}