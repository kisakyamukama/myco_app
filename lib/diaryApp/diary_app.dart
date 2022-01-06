import 'package:flutter/material.dart';
import 'package:myco/diaryApp/core/repository/diary_repository.dart';
import 'package:myco/diaryApp/ui/components/myco_snackbar.dart';
import 'package:myco/diaryApp/ui/journal_display.dart';

import 'core/model/model.dart';

class DiaryApp extends StatefulWidget {
  const DiaryApp({Key? key}) : super(key: key);

  @override
  State<DiaryApp> createState() => _DiaryAppState();
}

class _DiaryAppState extends State<DiaryApp> {
  @override
  void initState() {
    getJournals();
    super.initState();
  }

  List<Diary> journals = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'My Diary',
      )),
      body: ListView.builder(
        itemCount: journals.length,
        itemBuilder: (context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: JournalDisplay(journal: journals[index]),
        );
      }),
      floatingActionButton: FloatingActionButton(
        key: const Key('addJournal'),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, 'createJournal');
        },
      ),
    );
  }

  Future getJournals() async {
    DiaryRepository _diaryRepository = DiaryRepository();

    try {
      List<Diary> _journals = await _diaryRepository.getJournals();
      setState(() {
        journals.insertAll(0, _journals);
      });
    } catch (e) {
      mycoSnackBar(context, '$e');
    }
  }
}
