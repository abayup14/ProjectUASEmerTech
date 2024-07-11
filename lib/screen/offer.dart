import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_uas_emer_tech/class/animal.dart';
import 'package:project_uas_emer_tech/main.dart';
import 'package:project_uas_emer_tech/screen/edit_offer.dart';
import 'package:project_uas_emer_tech/screen/new_offer.dart';

class Offer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OfferState();
  }
}

class _OfferState extends State<Offer> {
  String _temp = 'waiting API respond…';
  List<Offers> animals = [];

  Future<String> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/offers_list.php"),
        body: {
          'owner_id': active_user.toString(),
        },
      );
      print('Response: ${response.body}');
      return response.body;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to read API');
    }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json["data"]) {
        Offers animal = Offers.fromJson(mov);
        animals.add(animal);
      }
      setState(() {
        // _temp = json['message'];
      });
    });
  }

  Widget DaftarOffer(offers) {
    if (offers != null) {
      return ListView.builder(
        itemCount: offers.length,
        itemBuilder: (BuildContext ctxt, int index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    offers[index].nama_hewan,
                  ),
                ),
                Text("Deskripsi: " + offers[index].keterangan),
                Image.network(offers[index].foto),
                Text("Jenis Hewan: " + offers[index].jenis_hewan),
                Text("Jumlah proposal: " +
                    offers[index].propose_count.toString()),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => EditOffer()));
                  },
                  child: Text("Edit Offer"),
                ),
              ],
            ),
          );
        },
      );
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
      appBar: AppBar(title: const Text("Offers")),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 175,
            child: DaftarOffer(animals),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewOffer()),
          );
        },
        tooltip: 'Add New Offer',
        child: Icon(Icons.add),
      ),
    );
  }
}
