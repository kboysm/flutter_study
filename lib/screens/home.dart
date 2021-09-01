import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'edit.dart';
import '../database/memo.dart';
import '../database/db.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
            child:
                Text('메모!', style: TextStyle(fontSize: 36, color: Colors.blue))),
            Expanded(child: memoBuilder())
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => EditPage()));
        },
        tooltip: "매모를 추가하려면 클릭!",
        label: Text('메모 추가'),
        icon: Icon(Icons.add),
      ),
    );
  }

  List<Widget> loadMemo() {
    List<Widget> memoList = [];
    memoList.add(Container(
      color: Colors.redAccent,
      height: 100,
    ));
    memoList.add(Container(
      color: Colors.purpleAccent,
      height: 100,
    ));
    return memoList;
  }

  Future<List<Memo>> loadMemolite() async {
    DBHelper sd = DBHelper();
    return await sd.memos();
  }

  Widget memoBuilder() {
    return FutureBuilder(builder: (context, projectSnap) {
      if ((projectSnap.data as List).isEmpty ) {
        return Container(child: Text('메모를 추가해보세요.'));
      }
      return ListView.builder(
          itemCount: (projectSnap.data as List).length,
          itemBuilder: (context, index) {
          Memo memo = (projectSnap.data as List)[index];
          return Column(
            children: [
              Text(memo.title),
              Text(memo.text),
              Text(memo.editTime),
            ],
          );
      });
    },
    future: loadMemolite(),
    );
  }
}
