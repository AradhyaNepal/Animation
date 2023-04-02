import 'package:flutter/material.dart';

class IntrinsicAnimationScreen extends StatefulWidget {
  static const String route="/IntrinsicAnimationScreen";
  static const String title="Intrinsic Animation Screen";
  const IntrinsicAnimationScreen({Key? key}) : super(key: key);

  @override
  State<IntrinsicAnimationScreen> createState() => _IntrinsicAnimationScreenState();
}

class _IntrinsicAnimationScreenState extends State<IntrinsicAnimationScreen> {
  bool _isExpanded=false;
  late Size _size;
  @override
  void didChangeDependencies() {
    _size=MediaQuery.of(context).size;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              IntrinsicAnimationScreen.title,
            ),
          ),
          body: Card(
            elevation: 10,
            color: Colors.grey,
            child: Container(
              padding: const EdgeInsets.all(20),
              height: _isExpanded?_size.height:_size.height*0.15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                            _isExpanded?"Expanded":"Minimized"
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            _isExpanded=!_isExpanded;
                          });
                        },
                        icon: Icon(
                          _isExpanded?Icons.arrow_drop_up_sharp:Icons.arrow_drop_down_sharp,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      color: _isExpanded?Colors.red:Colors.green,
                      child: const Center(
                        child: Icon(
                            Icons.ac_unit
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
