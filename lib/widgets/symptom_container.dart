import 'package:flutter/material.dart';

class SymptomContainer extends StatefulWidget {
  // SymptomContainer({Key key}) : super(key: key);
  final bool currentState;
  final String symptom;
  // final int radius;

  SymptomContainer({this.currentState, this.symptom
      // this.radius
      });

  @override
  _SymptomContainerState createState() => _SymptomContainerState();
}

class _SymptomContainerState extends State<SymptomContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        
          borderRadius: BorderRadius.circular(18.0),
          // side: BorderSide(color: Colors.red)),
        
        
        color: widget.currentState? Colors.deepPurpleAccent: Colors.grey,),
        // text
        // padding: EdgeInsets.all(8.0),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            "${widget.symptom}",
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.white,
            ),
          ),
        ),
    
    );
  }
}
