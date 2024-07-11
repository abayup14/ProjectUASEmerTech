import 'package:flutter/material.dart';

class EditOffer extends StatefulWidget {
  EditOffer({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditOffer();
  }
}

class _EditOffer extends State<EditOffer> {
  final _formKey = GlobalKey<FormState>();
  String _jenis_hewan = "";
  String _nama_hewan = "";
  String _foto = "";
  String _keterangan = "";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Offer"),
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
                  } else {}
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
