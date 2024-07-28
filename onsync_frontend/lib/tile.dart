import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext) {
    return Container(
      color: const Color(0xFFC19A6B),
      child: const Center(child: Text('Test')),
    );
  }
}
