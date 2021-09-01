import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var titleSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('테스트 텍스트 1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
            Text('테스트 텍스트 2',
                style: TextStyle(color: Colors.grey, fontSize: 26)),
          ],
        ),
        Padding(padding: EdgeInsets.all(20.0)),
        Icon(
          Icons.star,
          size: 35,
          color: Colors.deepOrange,
        ),
        Text('tutorial', style: TextStyle(fontSize: 30))
      ],
    );
    var buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(children: [
          Icon(Icons.call, size: 45, color: Colors.lightBlue),
          Text('Call', style: TextStyle(color: Colors.lightBlue))
        ]),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(children: [
          Icon(Icons.near_me, size: 45, color: Colors.lightBlue),
          Text('Route', style: TextStyle(color: Colors.lightBlue))
        ]),
        Padding(padding: EdgeInsets.all(40.0)),
        Column(children: [
          Icon(Icons.share, size: 45, color: Colors.lightBlue),
          Text('Share', style: TextStyle(color: Colors.lightBlue))
        ])
      ],
    );
    var textSection = Container(
        padding: EdgeInsets.all(30.0),
        child: Text(
            'To show right-aligned metadata (assuming left-to-right reading order; left-aligned for right-to-left reading order), consider using a Row with CrossAxisAlignment.baseline alignment whose first item is Expanded and whose second child is the metadata text, instead of using the trailing property.',
            style: TextStyle(fontSize: 20)));
    return Scaffold(
      body: Column(children: [
        Image.network(
            'https://image.msscdn.net/images/goods_img/20200114/1270359/1270359_1_500.jpg',
            height: 240,
            width: 600,
            fit: BoxFit.cover),
        Padding(padding: EdgeInsets.all(15.0)),
        titleSection,
        Padding(padding: EdgeInsets.all(15.0)),
        buttonSection,
        // Padding(padding: EdgeInsets.all(15.0)),
        textSection
      ]),
    );
  }
}
