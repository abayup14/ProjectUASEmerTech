import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas_emer_tech/screen/offer.dart';
import 'package:project_uas_emer_tech/main.dart';

class NewOffer extends StatefulWidget {
  const NewOffer({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewOffer();
  }
}

class _NewOffer extends State<NewOffer> {
  final _formKey = GlobalKey<FormState>();
  String _jenis_hewan = "";
  String _nama_hewan = "";
  String _foto = "";
  String _keterangan = "";

  void addOffer() async {
    final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/new_listing.php"),
        body: {
          'jenis': _jenis_hewan,
          'nama': _nama_hewan,
          'foto': _foto,
          'keterangan': _keterangan,
          'owner_id': active_user.toString()
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["result"] == "success") {
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Succesfully added data")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Offer()));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("error")));
      throw Exception("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("New Offer"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Jenis Hewan',
                  ),
                  onChanged: (value) {
                    _jenis_hewan = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Judul harus diisi';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nama Hewan',
                  ),
                  onChanged: (value) {
                    _nama_hewan = value;
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Foto Hewan',
                  ),
                  onChanged: (value) {
                    _foto = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Foto harus diisi';
                    }
                    return null;
                  },
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Keterangan',
                  ),
                  onChanged: (value) {
                    _keterangan = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Keterangan harus diisi';
                    }
                    return null;
                  },
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      !_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Harap Isian diperbaiki')));
                  } else {
                    addOffer();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
