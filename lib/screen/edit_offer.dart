import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_uas_emer_tech/class/animal.dart';
import 'package:project_uas_emer_tech/main.dart';
import 'package:project_uas_emer_tech/screen/offer.dart';

class EditOffer extends StatefulWidget {
  final int animal_id;

  EditOffer({Key? key, required this.animal_id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditOffer();
  }
}

class _EditOffer extends State<EditOffer> {
  final _formKey = GlobalKey<FormState>();
  late Animal anm;

  TextEditingController _namaHewanEdit = TextEditingController();
  TextEditingController _jenisHewanEdit = TextEditingController();
  TextEditingController _fotoHewanEdit = TextEditingController();
  TextEditingController _keteranganEdit = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/detail_offer.php"),
        body: {'id': widget.animal_id.toString()},
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        setState(() {
          anm = Animal.fromJson2(json['data']);
          _jenisHewanEdit.text = anm.jenis_hewan;
          _namaHewanEdit.text = anm.nama_hewan;
          _fotoHewanEdit.text = anm.foto;
          _keteranganEdit.text = anm.keterangan;
        });
      } else {
        throw Exception("Failed to load animal details");
      }
    } catch (e) {
      print("Error fetching data: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to load animal details"),
      ));
    }
  }

  void editOffer() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse(
              "https://ubaya.me/flutter/160421058/project_uas_et/edit_offer.php"),
          body: {
            'animal_id': widget.animal_id.toString(),
            'jenis': _jenisHewanEdit.text,
            'nama': _namaHewanEdit.text,
            'foto': _fotoHewanEdit.text,
            'keterangan': _keteranganEdit.text,
          },
        );
        if (response.statusCode == 200) {
          Map<String, dynamic> json = jsonDecode(response.body);
          if (json["result"] == "success") {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Successfully edited data"),
            ));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Offer()),
            );
          } else {
            throw Exception("Failed to edit data: ${json['message']}");
          }
        } else {
          throw Exception("Failed to edit data");
        }
      } catch (e) {
        print("Error editing data: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to edit data"),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Offer"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Jenis Hewan',
              ),
              controller: _jenisHewanEdit,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Jenis hewan harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nama Hewan',
              ),
              controller: _namaHewanEdit,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama hewan harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Foto Hewan',
              ),
              controller: _fotoHewanEdit,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Foto hewan harus diisi';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Keterangan',
              ),
              controller: _keteranganEdit,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Keterangan harus diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: editOffer,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
