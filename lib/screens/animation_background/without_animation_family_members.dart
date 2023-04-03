import 'package:animation/screens/animation_background/widgets/expensive_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/typedef.dart';

class WithoutFamilyMembersOfAnimation extends StatefulWidget {
  static const String route="/WithoutFamilyMembersOfAnimation";
  static const String title="Without Family Members Of Animation";
  const WithoutFamilyMembersOfAnimation({Key? key}) : super(key: key);

  @override
  State<WithoutFamilyMembersOfAnimation> createState() => _WithoutFamilyMembersOfAnimationState();
}

class _WithoutFamilyMembersOfAnimationState extends State<WithoutFamilyMembersOfAnimation> {
  bool _isSelected=true;
  String _enteredText="";
  final String _expensiveData="Bello!";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            WithoutFamilyMembersOfAnimation.title,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Entered Text: $_enteredText"),
            const SizedBox(height: 20,),
            Text("Is Selected: $_isSelected"),
            ExpensiveWidget(expensiveData: _expensiveData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text("Type Value: "),
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        setState(() {
                          _enteredText=value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            _CustomSwitch(
              isSelected: _isSelected,
              onChanged: (value) {
                _isSelected=value;
                setState(() {
                });
              },
            ),
            const SizedBox(height: 50,),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}




class _CustomSwitch extends StatelessWidget {
  final bool isSelected;
  final SwitchOnPressed onChanged;
  const _CustomSwitch({
    required this.isSelected,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This is Switch: "),
        Switch(
          value: isSelected,
          onChanged: onChanged,
        ),
        //And lots of other modifications in our switch
        //....
        //....
      ],
    );
  }
}


