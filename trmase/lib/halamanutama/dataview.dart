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
  var history;
  late List registered;
  TextEditingController _textFieldController = TextEditingController();

  void _TextFieldDialog(String uidkartu) {
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
                ref3.child(uidkartu).set(uid);
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
    history = List.empty();
    registered = List.empty();
    ref3.onValue.listen(onEntryAdded_name);
    ref.onValue.listen(onEntryAdded);
  }

  onEntryAdded(event) {
    setState(() {
      history =
          event.snapshot.children.map((e) => History.fromSnapshot(e)).toList();
    });
  }

  onEntryAdded_name(event) {
    setState(() {
      registered =
          event.snapshot.children.map((e) => uid.fromSnapshot(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.outlineVariant,
      body: Column(children: [
        Expanded(child: Builder(builder: (context) {
          if (history.length > 0) {
            return ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, i) {
                  int ri = history.length - (i + 1);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      dense: true,
                      tileColor: Theme.of(context).colorScheme.background,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.tertiary),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      title: Text(history[ri].uid),
                      subtitle: Text(history[ri].tanggal,
                          style: Theme.of(context).textTheme.bodySmall),
                      onTap: () {
                        return _TextFieldDialog(history[ri].uid);
                      },
                    ),
                  );
                });
          } else {
            return CircularProgressIndicator();
          }
        }))
      ]),
    );
  }
}
