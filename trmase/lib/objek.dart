import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class History {
  String key;
  String uid;
  String tanggal;

  History(this.key, this.uid, this.tanggal);

  History.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key as String,
        uid = snapshot.child('UID').value as String,
        tanggal = snapshot.child('time').value as String;
}

class uid {
  String key;
  String nama;
  uid(this.key, this.nama);
  uid.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key as String,
        nama = snapshot.value as String;
}
