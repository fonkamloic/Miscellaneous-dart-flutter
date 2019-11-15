import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
//      theme: CupertinoThemeData(
//        textTheme: CupertinoTextThemeData(
//          navLargeTitleTextStyle: TextStyle(
//            fontSize: 70.0,
//            color: CupertinoColors.activeBlue,
//            fontWeight: FontWeight.bold,
//          ),
//        ),
//      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.book_solid),
            title: Text('Articles'),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.eye_solid),
            title: Text('Views'),
          ),
        ],
      ),
      tabBuilder: (context, i) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: (i == 0) ? Text('Articles') : Text('Views'),
              ),
              child: Center(
                child: CupertinoButton(
                  child: Text(
                    'This is tab #$i',
                    style: CupertinoTheme.of(context)
                        .textTheme
                        .actionTextStyle
                        .copyWith(fontSize: 32),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        builder: (context) {
                          return DetailScreen(
                              topic: i == 0 ? 'Articles' : 'View');
                        },
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String topic;
  DetailScreen({this.topic});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Details"),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text('A Switch'),
                  ),
                  CupertinoSwitch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(
                        () {
                          switchValue = value;
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              CupertinoButton(
                child: Text('Lauch action sheet'),
                onPressed: () {
                  showCupertinoModalPopup<int>(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          title: Text('Some choices'),
                          actions: [
                            CupertinoActionSheetAction(
                              child: Text('One!'),
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                              isDefaultAction: true,
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Two!'),
                              onPressed: () {
                                Navigator.pop(context, 2);
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text('Three!'),
                              onPressed: () {
                                Navigator.pop(context, 3);
                              },
                            ),
                          ],
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

