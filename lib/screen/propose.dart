import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_uas_emer_tech/main.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas_emer_tech/screen/browse.dart';

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
  final _formKey = GlobalKey<FormState>();
  String _komen_propose = "";

  void propose() async {
    final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/propose.php"),
        body: {
          'uid': active_user.toString(),
          'aid': widget.animal_id.toString(),
          'description': _komen_propose
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["result"] == "success") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Succesfully proposed to the animal owner")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Propose To Your Favorite Animal"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                decoration:
                    const InputDecoration(labelText: "Give your best proposal"),
                onChanged: (value) {
                  _komen_propose = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your proposal";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      !_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please input all of the text input")));
                  } else {
                    propose();
                  }
                },
                child: Text("Propose"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
