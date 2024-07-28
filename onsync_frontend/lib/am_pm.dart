import 'package:flutter/material.dart';

class AM_PM extends StatelessWidget {
  final bool isItAm;


  AM_PM({required this.isItAm});

  @override
  Widget build(BuildContext) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        child: Center(
          child: Text(
          isItAm == true ? 'AM':'PM',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          
        ),),),
      ),
    );
  }
}
