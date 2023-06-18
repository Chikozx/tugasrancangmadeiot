import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trmase/objek.dart';

class DataView extends StatefulWidget {
  const DataView({super.key});

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState extends State<DataView> {
  final ref = FirebaseDatabase.instance.ref('uid/history_log');
  final ref3 = FirebaseDatabase.instance.ref('uid/access');
  late List<History> history;
  TextEditingController _textFieldController = TextEditingController();

  void _TextFieldDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Silahkan registrasi UID-nya di kolom ini'),
          content: TextField(
            controller: _textFieldController,
            decoration:
                InputDecoration(hintText: "Silahkan Masukkan Nama Anda"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                String uid = _textFieldController.text;
                print('UID yang dimasukkan: $uid');
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('UID Anda sudah Teregistrasi')),
                );
              },
              child: Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    ref.onValue.listen((event) {
      history =
          event.snapshot.children.map((e) => History.fromSnapshot(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: Column(children: [
        Expanded(
          child: FirebaseAnimatedList(
            reverse: true,
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
                child: ListTile(
                  onTap: () => _TextFieldDialog(),
                  tileColor: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Text(snapshot.child('UID').value.toString()),
                  subtitle: Text(snapshot.child('time').value.toString()),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}

class uid {
  String key;
  String nama;
  uid(this.key, this.nama);
}
