import 'dart:io';

import 'package:flutter/material.dart';

class ExpensiveWidget extends StatelessWidget {
  final String expensiveData;
  const ExpensiveWidget({required this.expensiveData,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Expensive Widget was rebuild");
    _performExpensiveTask();
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(vertical: 50),
        color: Colors.red,
        child: const Text("Expensive Widget")
    );
  }

  void _performExpensiveTask() {
    sleep(const Duration(milliseconds: 1000));
  }
}

