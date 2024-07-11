import 'package:flutter/material.dart';

class Propose extends StatefulWidget {
  int animal_id;
  Propose({super.key, required this.animal_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Propose();
  }
}

class _Propose extends State<Propose> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Propose To Your Favorite Animal"),
      ),
      body: ,
    );
  }
}
