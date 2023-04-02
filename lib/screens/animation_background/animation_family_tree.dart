import 'package:animation/screens/animation_background/widgets/expensive_widget.dart';
import 'package:flutter/material.dart';

class _CustomSwitch extends StatelessWidget {
  final ValueNotifier<bool> isSelected;
  const _CustomSwitch({
    required this.isSelected,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("This is Switch: "),
        ValueListenableBuilder<bool>(
          valueListenable: isSelected,
          builder: (context,value,child) {
            return Switch(
              value: value,
              onChanged: (value){
                isSelected.value=value;
              },
            );
          }
        ),
        //And lots of other modifications in our switch
        //....
        //....
      ],
    );
  }
}

class AnimationFamilyTree extends StatefulWidget {
  static const String route="/AnimationFamilyTree";
  static const String title="Animation Family Tree";
  const AnimationFamilyTree({Key? key}) : super(key: key);

  @override
  State<AnimationFamilyTree> createState() => _AnimationFamilyTreeState();
}

class _AnimationFamilyTreeState extends State<AnimationFamilyTree> {
  final ValueNotifier<bool> _isSelected=ValueNotifier(true);
  final TextEditingController _enteredText=TextEditingController();
  final String _expensiveData="Bello!";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: _enteredText,
              builder: (context,value,child) {
                return Text("Entered Text: ${_enteredText.text}");
              }
            ),
            const SizedBox(height: 20,),
            ValueListenableBuilder<bool>(
              valueListenable: _isSelected,
              builder: (context,value,child) {
                return Text("Is Selected: $value");
              }
            ),
            ExpensiveWidget(expensiveData: _expensiveData,),
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
            const SizedBox(height: 50,),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
































































































  @override
  void dispose() {
    _isSelected.dispose();
    _enteredText.dispose();
    super.dispose();
  }
}
