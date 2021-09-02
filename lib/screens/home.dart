import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'edit.dart';
import '../database/memo.dart';
import '../database/db.dart';
import 'view.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String deleteId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 5, top: 40, bottom: 20),
            child: Text('메모!',
                style: TextStyle(fontSize: 36, color: Colors.blue))),
        Expanded(child: memoBuilder(context)),
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

  Future<void> deleteMemo(String id) async {
    DBHelper sd = DBHelper();
    await sd.deleteMemo(id);
  }

  void shwAlertDialog(BuildContext context) async {
    String result = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('정말 삭제하시겠습니까?'),
            content: Text('진짜로??'),
            actions: [
              FlatButton(
                child: Text('삭제'),
                onPressed: () {
                  Navigator.pop(context, "삭제");
                  setState(() {
                    deleteMemo(deleteId);
                  });
                  deleteId = '';
                },
              ),
              FlatButton(
                child: Text('취소'),
                onPressed: () {
                  deleteId = '';
                  Navigator.pop(context, "취소");
                },
              )
            ],
          );
        });
  }

  Widget memoBuilder(BuildContext parentContext) {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if ((projectSnap.data as List).isEmpty) {
          return Container(child: Text('메모를 추가해보세요.'));
        }
        return ListView.builder(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(left: 25, right: 25),
            itemCount: (projectSnap.data as List).length,
            itemBuilder: (context, index) {
              Memo memo = (projectSnap.data as List)[index];
              return InkWell(
                onTap: () {
                  Navigator.push(
                      parentContext,
                      CupertinoPageRoute(
                          builder: (context) => ViewPage(id: memo.id)));
                },
                onLongPress: () {
                  deleteId = memo.id;
                  shwAlertDialog(parentContext);
                },
                child: Container(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.blue,
                        width: 1,
                      ),
                      boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 3)],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(memo.title,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis, // 텍스트가 해당 박스의 크기를 넘어버리는 양이라면 적절한곳에서 끊어주고 ... 으로 처리해주는 옵션
                            ),
                            Text(memo.text, style: TextStyle(fontSize: 15),overflow: TextOverflow.ellipsis),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text("최종 수정 시간: " + memo.editTime.split('.')[0],
                                style: TextStyle(fontSize: 11),
                                textAlign: TextAlign.end),
                          ],
                        ),
                      ],
                    )),
              );
            });
      },
      future: loadMemolite(),
    );
  }
}
