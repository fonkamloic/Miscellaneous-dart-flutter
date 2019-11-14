import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome to Flutter",
      home: RandomWords(),
      theme: ThemeData(primaryColor: Colors.white),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final WordPair wordPair = WordPair.random();
  final List<WordPair> _suggestions = [];
  final TextStyle _biggerFont = TextStyle(fontSize: 18);
  final Set<WordPair> favouriteName = Set<WordPair>();
  Widget _buildSuggestion() {
    return ListView.builder(
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        final int index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
      padding: EdgeInsets.all(16),
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pair.asCamelCase,
            style: _biggerFont,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (favouriteName.contains(pair) == true) {
                  favouriteName.remove(pair);
                } else
                  favouriteName.add(pair);
              });
            },
            icon: favouriteName.contains(pair)
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_border),
            color: favouriteName.contains(pair) ? Colors.red : Colors.black54,
          ),
        ],
      ),
    );
  }

  void _pushFavourite() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final Iterable<ListTile> tiles = favouriteName.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asCamelCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided =
              ListTile.divideTiles(tiles: tiles, context: context).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(
              children: divided,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushFavourite,
          )
        ],
      ),
      body: _buildSuggestion(),
    );
  }
}

class FavouriteNames extends StatefulWidget {
  @override
  _FavouriteNamesState createState() => _FavouriteNamesState();
}

class _FavouriteNamesState extends State<FavouriteNames> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

