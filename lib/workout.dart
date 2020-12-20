import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  Workout(DocumentSnapshot doc) {
    this.documentReference = doc.reference;
    this.title = doc.data()['title'];
    this.count = doc.data()['count'];

    final Timestamp timestamp = doc.data()['createdAt'];
    this.createdAt = timestamp.toDate();

  }

  String title;
  DateTime createdAt;
  int count;
  bool isDone = false;
  DocumentReference documentReference;

}