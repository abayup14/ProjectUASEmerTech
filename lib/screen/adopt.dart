import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project_uas_emer_tech/class/animal.dart';
import 'package:project_uas_emer_tech/main.dart';

// class Adopt extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Center(
//         child: Text("Home"),
//       ),
//     );
//   }
// }
class Adopts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdoptsState();
  }
}

class _AdoptsState extends State<Adopts> {
  String _temp = 'waiting API respond…';
  List<Adopt> animals = [];
  Future<String> fetchData() async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://ubaya.me/flutter/160421058/project_uas_et/adopt_list.php"),
          body: {
            'uid': active_user.toString(),
          });
      print('Response: ${response.body}');
      return response.body;
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to read API');
    }
    // final response = await http.post(
    //     Uri.parse(
    //         "https://ubaya.me/flutter/160421058/project_uas_et/adopt_list.php"),
    //     body: {
    //       'uid': active_user,
    //     });
    // if (response.statusCode == 200) {
    //   return response.body;
    // } else {
    //   throw Exception('Failed to read API');
    // }
  }

  bacaData() {
    Future<String> data = fetchData();
    data.then((value) {
      Map json = jsonDecode(value);
      for (var mov in json["data"]) {
        Adopt animal = Adopt.fromJson(mov);
        animals.add(animal);
      }
      setState(() {
        // _temp = json['message'];
      });
    });
  }

  Widget DaftarAdopt(adopts) {
    if (adopts != null) {
      return ListView.builder(
          itemCount: adopts.length,
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
                      adopts[index].nama_hewan),
                  Text("Deskripsi: " + adopts[index].keterangan),
                  Image.network(adopts[index].foto),
                  Text("Jenis Hewan: " + adopts[index].jenis_hewan),
                  Text("Status: " + adopts[index].status2),
              ],
            ));
          });
    } else {
      return CircularProgressIndicator();
    }
  }

//   Widget DaftarAdopt2(data) {
//   List<Animal> animals2 = [];
//   Map json = jsonDecode(data);
//   for (var mov in json['data']) {
//    Animal animal = Animal.fromJson(mov);
//    animals2.add(animal);
//   }
//   return ListView.builder(
//     itemCount: animals2.length,
//     itemBuilder: (BuildContext ctxt, int index) {
//      return Card(
//        child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//        ListTile(
//         leading: Icon(Icons.movie, size: 30),
//         title: Text(animals2[index].nama_hewan),
//         subtitle: Text(animals2[index].keterangan),
//        ),
//       ],
//      ));
//     });
//  }

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height - 200,
          child: DaftarAdopt(animals),
        ),
        // Container(
        //     height: MediaQuery.of(context).size.height / 2,
        //     child: FutureBuilder(
        //         future: fetchData(),
        //         builder: (context, snapshot) {
        //           if (snapshot.hasData) {
        //             return DaftarAdopt2(snapshot.requireData);
        //           } else {
        //             return Center(child: CircularProgressIndicator());
        //           }
        //         }))
      ]),
    );
  }

  // void delete(int id) async {
  //   final response = await http
  //       .post(Uri.parse("https://ubaya.me/flutter/160421013/deletemovie.php"), body: {
  //     'movie_id': id.toString(),
  //   });
  //   if (response.statusCode == 200) {
  //     Map json = jsonDecode(response.body);
  //     if (json['result'] == 'success') {
  //       if (!mounted) return;
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('Sukses Menghapus Data')));
  //           bacaData();
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text('Error')));
  //     throw Exception('Failed to read API');
  //   }
  // }
}
