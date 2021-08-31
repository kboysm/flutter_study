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
      children: [
        Column(
          children: [
            Text('테스트 텍스트 1'),
            Text('테스트 텍스트 2'),
          ],
        ),
        Icon(Icons.star),
        Text('tutorial')
      ],
    );
    var buttonSection = Row(
      children: [
        Column(children: [Icon(Icons.call), Text('Call')]),
        Column(children: [Icon(Icons.near_me), Text('Call')]),
        Column(children: [Icon(Icons.share), Text('Call')])
      ],
    );
    var textSection = Text('asdasd');
    return Scaffold(
      body: Column(children: [
        Image.network(
            'https://image.msscdn.net/images/goods_img/20200114/1270359/1270359_1_500.jpg',
            height: 240,
            width: 600,
            fit: BoxFit.cover),
        titleSection,
        buttonSection,
        textSection
      ]),
    );
  }
}
