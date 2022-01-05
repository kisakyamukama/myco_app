import 'package:flutter/material.dart';

class DiaryApp extends StatelessWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'My Diary',
      )),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        key: const Key('addJournal'),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'createJournal');
        },
      ),
    );
  }
}
