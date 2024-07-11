import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_uas_emer_tech/main.dart';
import 'package:project_uas_emer_tech/class/animal.dart';
import 'package:project_uas_emer_tech/screen/offer.dart';
import 'package:http/http.dart' as http;

class Decision extends StatefulWidget {
  int animal_id;
  Decision({super.key, required this.animal_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Decision();
  }
}

class _Decision extends State<Decision> {
  final _formKey = GlobalKey<FormState>();
  // String _komen_propose = "";
  List<Decisions> listDecisions = [];
  Future<String> fetchData() async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://ubaya.me/flutter/160421058/project_uas_et/decision_list.php"),
          body: {
            'animal_id': widget.animal_id.toString(),
          });
      print('Response: ${response.body}');
      return response.body;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to read API');
    }
  }

  void decide(int adopter_id) async {
    final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/decide.php"),
        body: {
          'adopter_id': adopter_id.toString(),
          'animal_id': widget.animal_id.toString()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["result"] == "success") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Succesfully accepted the proposal")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyApp()));
      }
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json["data"]) {
        Decisions temp = Decisions.fromJson(mov);
        listDecisions.add(temp);
      }
      setState(() {
        // _temp = json['message'];
      });
    });
  }

  Widget DaftarDecision(decisions) {
    if (decisions != null) {
      return ListView.builder(
          itemCount: decisions.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      decisions[index].fullname),
                  Text("Deskripsi: " + decisions[index].description),
                  ElevatedButton(
                    onPressed: () {
                      decide(decisions[index].id_adopters);
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  )
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Decisions"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 200,
          child: DaftarDecision(listDecisions),
        ),
      ]),
    );
  }
}