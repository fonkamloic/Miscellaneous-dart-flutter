import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          buttonColor: Colors.purple,
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          )),
      home: MyHomePage(),
    );
  }
}

class Kitten {
  Kitten({this.name, this.description, this.age, this.imageUrl});
  final String name, description, imageUrl;
  final int age;
}

final String server =
    defaultTargetPlatform == TargetPlatform.android ? "10.0.2.2" : "0.0.0.0";

final List<Kitten> _kittens = <Kitten>[
  Kitten(
    name: 'Mittens',
    description:
        'The pinnacle of cats. when Mittens sits in your lap, you feel like royalty.',
    age: 11,
    imageUrl: 'http://$server:8000/Kitten0.jpeg',
  ),
  Kitten(
    name: 'Fluffy',
    description: "World's cutest kitten. Seriously. We did the research.",
    age: 3,
    imageUrl: 'http://$server:8000/Kitten1.jpeg',
  ),
  Kitten(
    name: 'Scooter',
    description: 'Chases string faster than 9/10 compting kittens',
    age: 2,
    imageUrl: 'http://$server:8000/Kitten2.jpeg',
  ),
  Kitten(
    name: 'Steve',
    description: 'Steve is coo and just kind of hangs of hangs out',
    age: 4,
    imageUrl: 'http://$server:8000/Kitten3.jpeg',
  ),
];

class MyHomePage extends StatelessWidget {
  Widget _dialogBuilder(BuildContext context, Kitten kitten) {
    ThemeData localTheme = Theme.of(context);
    return SimpleDialog(
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        Image.network(
          kitten.imageUrl,
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                kitten.name,
                style: localTheme.textTheme.display1,
              ),
              Text(
                "${kitten.age} month old.",
                style: localTheme.textTheme.subhead
                    .copyWith(fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                kitten.description,
                style: localTheme.textTheme.body1,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Wrap(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("I'M ALLEGIC"),
                    ),
                    RaisedButton(
                      onPressed: () {},
                      child: Text("ADOPT"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => _dialogBuilder(context, _kittens[index]),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 16.0, top: 5),
        alignment: Alignment.centerLeft,
        child: Text(
          _kittens[index].name,
          style: Theme.of(context).textTheme.headline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Available Kittens"),
      ),
      body: ListView.builder(
        itemBuilder: _listItemBuilder,
        itemCount: _kittens.length,
        itemExtent: 60.0,
      ),
    );
  }
}

