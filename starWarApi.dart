import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

void main() => runApp(StarWar());

class StarWar extends StatefulWidget {
  @override
  _StarWarState createState() => _StarWarState();
}

class _StarWarState extends State<StarWar> {
  final String url = "https://swapi.co/api/starships";

  @override
  void initState() {
    super.initState();
    dynamic succes = getSWData();
    if (succes == "Success!") {
      print("data was fetched");
    } else
      print("An error occured");
  }

  List data;

  Future<String> getSWData() async {
    http.Response res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var decodedData = jsonDecode(res.body);
      data = decodedData['results'];
    });
    return "Success!";
  }

  List<StarWarCard> starWarList = [];

  @override
  Widget build(BuildContext context) {
    int i = 0;
    data.forEach((var each) {
      starWarList.add(
        StarWarCard(
          index: i++,
          data: data,
        ),
      );
    });
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Star war Starships'),
          backgroundColor: Colors.amber,
        ),
        body: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: starWarList,
                ),
              ),
            );
          },
          itemCount: data == null ? 0 : data.length,
        ),
      ),
    );
  }
}

class StarWarCard extends StatelessWidget {
  StarWarCard({this.data, this.index});
  final dynamic data;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          child: Container(
            child: Text(
              data[index]["name"],
              style: TextStyle(fontSize: 18.0, color: Colors.black54),
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Card(
          child: Container(
            child: Text(
              data[index]['model'],
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}

