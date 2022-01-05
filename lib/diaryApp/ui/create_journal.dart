import 'package:flutter/material.dart';

class CreateJournalScreen extends StatelessWidget {
  const CreateJournalScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(),
          TextFormField(),
          ElevatedButton(onPressed: (){}, child: Text('submit'it))

        ],
      ),
      
    );
  }
}