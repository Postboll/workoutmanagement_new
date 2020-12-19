import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workout_management/add/add_page.dart';
import 'main_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dem',
      theme: ThemeData.dark(
      ),
      home: MainPage(),
    );
  }
}



class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel()..getWorkoutListRealtime(),

      child: Scaffold(

        appBar: AppBar(
          title: Text("Workout Management"),
          actions: [
              Consumer<MainModel>(builder: (context, model, child){
                final isActive = model.checkShouldActiveCompleteButton();


                return FlatButton(onPressed: isActive
                  ? () async {

                  await model.deletedItems();

                  }
                  : null,
                    child: Text(
                    '削除',
                  style: TextStyle(color: isActive ?
                      Colors.blue.withOpacity(0.8)

                  : Colors.white),
                ));
              }
            )
          ],
        ),

        body: Consumer<MainModel>(builder: (context, model, child) {

          final workoutList = model.workoutList;

          return GridView.builder(
            
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

            itemBuilder: (BuildContext context, int index) {

              return Container(

                child: Padding(

                  padding: const EdgeInsets.all(10.0),

                  child: Stack(

                    children: workoutList
                        .map(
                          (workout) => CheckboxListTile(
                        title: Text(workout.title),
                        value: workout.isDone,
                        onChanged: (bool value) {
                          workout.isDone = !workout.isDone;
                          model.reload();
                        },
                      ),
                    ).toList(),

                  ),

                )
              );

            },




          );




        }),

        
        floatingActionButton: Consumer<MainModel>(builder: (context, model, child) {

            return FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddPage(model),
                  ),
                );
              },
            );
          }
        ),
      ),
    );
  }
}
