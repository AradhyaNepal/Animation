import 'package:animation/screens/animation_background/widgets/expensive_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/lag_indicator_widget.dart';

class AnimationFamilyTree extends StatefulWidget {
  static const String route = "/AnimationFamilyTree";
  static const String title = "Animation Family Tree";

  const AnimationFamilyTree({Key? key}) : super(key: key);

  @override
  State<AnimationFamilyTree> createState() => _AnimationFamilyTreeState();
}

class _AnimationFamilyTreeState extends State<AnimationFamilyTree> {
  final ValueNotifier<bool> _isSelected = ValueNotifier(true);
  final TextEditingController _enteredText = TextEditingController();
  final String _expensiveData = "Bello!";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            AnimationFamilyTree.title,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExpensiveWidget(
                expensiveData: _expensiveData,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Output",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                        valueListenable: _enteredText,
                        builder: (context, value, child) {
                          return Text("Entered Text: ${_enteredText.text}");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: _isSelected,
                        builder: (context, value, child) {
                          return Text("Is Selected: $value");
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const LagIndicationWidget(),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Input",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Text("Type Value: "),
                          Expanded(
                            child: TextField(
                              controller: _enteredText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _CustomSwitch(
                      isSelected: _isSelected,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> isSelected;

  const _CustomSwitch({required this.isSelected, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This is Switch: "),
        ValueListenableBuilder<bool>(
            valueListenable: isSelected,
            builder: (context, value, child) {
              return Switch(
                value: value,
                onChanged: (value) {
                  isSelected.value = value;
                },
              );
            }),
        //And lots of other modifications in our switch
        //....
        //....
      ],
    );
  }
}

//Todo: Memory Leak
