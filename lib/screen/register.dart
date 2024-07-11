import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_uas_emer_tech/screen/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Register();
  }
}

class _Register extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _fullname = "";
  String _password = "";

  void register() async {
    final response = await http.post(
        Uri.parse(
            "https://ubaya.me/flutter/160421058/project_uas_et/register.php"),
        body: {
          "username": _username,
          "fullname": _fullname,
          "password": _password,
        });
    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      if (json["result"] == "success") {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                "Successfully registered. Please login using your username and password.")));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLogin()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Failed to register")));
        throw Exception("Failed");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Register"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyLogin()));
            },
          ),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                height: 500,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    border: Border.all(width: 1),
                    color: Colors.white,
                    boxShadow: [const BoxShadow(blurRadius: 20)]),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                            hintText: "Enter your username here"),
                        onChanged: (v) {
                          _username = v;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username must be filled";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Full Name",
                            hintText: "Enter your fullname here"),
                        onChanged: (v) {
                          _fullname = v;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Full Name must be filled";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Password",
                            hintText: "Enter your password here"),
                        obscureText: true,
                        onChanged: (v) {
                          _password = v;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password must be filled";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState != null &&
                                  !_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please validate your input")));
                              } else {
                                register();
                              }
                            },
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 25),
                            ),
                          ),
                        )),
                  ],
                ))));
  }
}
