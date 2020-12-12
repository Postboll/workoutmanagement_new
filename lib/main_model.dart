
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workout_management/workout.dart';

class MainModel extends ChangeNotifier{

  List<Workout> workoutList = [];
  String newWorkoutText = '';

  Future getWorkoutList() async {

    final snapshot = await FirebaseFirestore.instance.collection('workoutList').get();
    final docs = snapshot.docs;
    final workoutList = docs.map((doc) => Workout(doc)).toList();
    this.workoutList = workoutList;
    notifyListeners();
  }

  void getWorkoutListRealtime(){
    final snapshots =
     FirebaseFirestore.instance.collection('workoutList').snapshots();
    snapshots.listen((snapshot) {

      final  docs = snapshot.docs;
      final workoutList = docs.map((doc) => Workout(doc)).toList();
      workoutList.sort((a , b) => b.createdAt.compareTo(a.createdAt));
      this.workoutList = workoutList;
      notifyListeners();
    }
    );

  }

  Future add() async{
    final collection = FirebaseFirestore.instance.collection("workoutList");
    await collection.add({
      'title': newWorkoutText,
      'createdAt': Timestamp.now(),
    });

  }

  void reload() {
    notifyListeners();
  }

  Future deletedItems() async {

    final checkedItems = workoutList.where((workout) => workout.isDone).toList();
    final references =
    checkedItems.map((workout) => workout.documentReference).toList();

    final batch = FirebaseFirestore.instance.batch();

    references.forEach((references) {
      batch.delete(references);

      return batch.commit();
    });


  }

  bool checkShouldActiveCompleteButton(){
    final checkedItems = workoutList.where((workout) => workout.isDone).toList();
    return checkedItems.length > 0 ;
  }

}