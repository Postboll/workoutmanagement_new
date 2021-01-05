import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_management/main_model.dart';


List<String> reportList = [
  "Not relevant",
  "Illegal",
  "Spam",
  "Offensive",
  "Uncivil"
];



class AddPage extends StatefulWidget {

  List<String> reportList;

  MainModel model;

  AddPage(this.model);

  @override
  _AddPage createState() => _AddPage();

}



class _AddPage extends State<AddPage> {

  String selectedChoice = "";

  MainModel model;

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {


    return ChangeNotifierProvider<MainModel>.value(

      value: MainModel(),


      child: Scaffold(

        appBar: AppBar(
          title: Text("Workout Management"),
        ),

        body: Consumer<MainModel>(builder: (context, model, child){

          List<Widget> choices = List();

          return Padding(

            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: '新しい筋トレ',
                    hintText: 'Input',
                  ),
                  onChanged: (text){
                    model.newWorkoutText = text;
                  },
                ),

                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  onChanged: (text) {
                    model.newWorkoutDigit = text as int;
                  },
                ),


                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: ChoiceChip(
                    label: Text("ジム"),
                    selected: isSelected,
                    selectedColor: Colors.teal,
                    onSelected: (selected) {
                      setState (() {
                        isSelected = selected;
                      });
                  },
                  ),

                ),



                RaisedButton(
                  child: Text('筋トレ登録！'),
                    onPressed: () async {
                  //Firestoreに値を追加する
                      await model.add();
                      Navigator.pop(context);
                }),
              ],
            ),
          );
        }),


      ),
    );
  }
}

