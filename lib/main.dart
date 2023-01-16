import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePAgeState();
}

class _HomePAgeState extends State<HomePage> {
  List apiCalling = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: apiCalling.length,
        itemBuilder: (context, index) {
          final PostId = apiCalling[index];
          final Name = PostId["name"];
          final id = PostId["id"];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(id.toString()),
            ),
            title: Text(Name),
            // subtitle: Text(id.toString()),
          );
        },
      ),
    );
  }

  void fetchPosts() async {
    final url = "https://jsonplaceholder.typicode.com/comments";
    // print("$url");
    final uri = Uri.parse(url);
    final responce = await http.get(uri);
    if (responce.statusCode == 200) {
      final json = jsonDecode(responce.body) as List;
      setState(() {
        apiCalling = apiCalling + json;
      });
    } else {
      print("Unexpected responce");
    }
  }
}
