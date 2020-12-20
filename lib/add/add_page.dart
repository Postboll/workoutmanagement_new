import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:workout_management/main_model.dart';


class AddPage extends StatelessWidget {

  final MainModel model;
  AddPage(this.model);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<MainModel>.value(
      value: MainModel(),

      child: Scaffold(

        appBar: AppBar(
          title: Text("Workout Management"),
        ),

        body: Consumer<MainModel>(builder: (context, model, child){

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
                SizedBox(
                  height: 16,
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
