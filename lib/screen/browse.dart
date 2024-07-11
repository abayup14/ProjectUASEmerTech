import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas_emer_tech/class/animal.dart';
import 'package:project_uas_emer_tech/screen/propose.dart';
import 'package:project_uas_emer_tech/main.dart';

class Browse extends StatefulWidget {
  const Browse({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Browse();
  }
}

class _Browse extends State<Browse> {
  List<Animal> listAnimal = [];
  String _temp = "Searching Animal...";
  Future<String> fetchData() async {
    final response = await http.get(Uri.parse(
        "https://ubaya.me/flutter/160421058/project_uas_et/browse_listing.php"));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to load animal.");
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var anm in json["data"]) {
        Animal a = Animal.fromJson(anm);
        listAnimal.add(a);
      }
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  Widget ListAnimalBrowse(listAnimal) {
    if (listAnimal != null) {
      return ListView.builder(
          itemCount: listAnimal.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    listAnimal[index].nama_hewan,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text("Deskripsi: " + listAnimal[index].keterangan),
                  Image.network(listAnimal[index].foto),
                  Text("Jenis Hewan: " + listAnimal[index].jenis_hewan),
                  Text("Nama Owner: " + listAnimal[index].nama_owner),
                  Text("Status: " + listAnimal[index].status),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Propose(animal_id: listAnimal[index].id)));
                    },
                    child: Text(
                      'Propose',
                    ),
                  )
                ],
              ),
            );
          });
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: const Text("List Animal")),
      body: ListAnimalBrowse(listAnimal),
    );
  }
}
