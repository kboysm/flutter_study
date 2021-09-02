import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../database/memo.dart';
import '../database/db.dart';

class ViewPage extends StatelessWidget {
  const ViewPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: LoadBuilder()
        ));
  }
  Future<List<Memo>> loadMemo(String id) async {
    DBHelper sd = DBHelper();
    return await sd.findMemo(id);
  }

  LoadBuilder() {
    return FutureBuilder<List<Memo>>(
      future: loadMemo(id),
      builder: (BuildContext context, AsyncSnapshot<List<Memo>> snapshot) {
      if ((snapshot.data as List).isEmpty) {
        return Container(
          child: Text('데이터를 불러올 수 없습니다.'),
        );
      } else {
        Memo memo = (snapshot.data as List)[0];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(memo.title, style: TextStyle(fontSize:30, fontWeight:FontWeight.w500)),
            Text('메모 만든 시간 : '+memo.createTime.split('.')[0],style:TextStyle(fontSize:11),textAlign: TextAlign.end),
            Text('메모 수정 시간 : '+ memo.editTime.split('.')[0],style:TextStyle(fontSize:11),textAlign: TextAlign.end),
            Padding(padding: EdgeInsets.all(10)),
            Expanded(child:Text(memo.text),
            )

          ],
        );
      }
    }
    );
  }

}

