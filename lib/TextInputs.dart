import 'package:flutter/material.dart';


class TextInputs extends StatefulWidget {
  @override
  _TextInputsState createState() => _TextInputsState();
}

class _TextInputsState extends State<TextInputs> {

final myController = new TextEditingController();

textListner(){
  print('text is ${myController.text}');
}

@override
  void initState() {
    super.initState();
    myController.addListener(() {textListner();});
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Inputs'),
        centerTitle: true,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (text){
                print('text is ${text}');
              },
            ),

            TextField(
              controller: myController,
            )
          ],
        ),
      ),
    );
  }
}