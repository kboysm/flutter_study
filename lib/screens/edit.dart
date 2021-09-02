import 'package:first_flutter_project/database/db.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../database/memo.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class EditPage extends StatelessWidget {
  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(onPressed: saveDB, icon: const Icon(Icons.save)),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            TextField(
                onChanged: (String title) {
                  this.title = title;
                },
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                // obscureText: true, 패스워드 처럼 **로 나오게하는 옵션
                decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: '제목')),
            Padding(padding: EdgeInsets.all(10)),
            TextField(
                onChanged: (String text) {
                  this.text = text;
                },
                // obscureText: true, 패스워드 처럼 **로 나오게하는 옵션
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                    // border: OutlineInputBorder(),
                    hintText: '내용')),
          ]),
        ));
  }

  Future<void> saveDB() async {
    DBHelper sd = DBHelper();

    var fido = Memo(
      id: Str2Sha256(DateTime.now().toString()),
      title: this.title,
      text: this.text,
      createTime: DateTime.now().toString(),
      editTime: DateTime.now().toString(),
    );

    await sd.insertMemo(fido);

    print(await sd.memos());
  }

  String Str2Sha256(String text) {
    var bytes = utf8.encode(text); // data being hashed
    var digest = sha512.convert(bytes);
    return digest.toString();
  }
}
