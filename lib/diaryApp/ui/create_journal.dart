import 'package:flutter/material.dart';
import 'package:myco/diaryApp/core/model/model.dart';
import 'package:myco/diaryApp/core/repository/diary_repository.dart';
import 'package:myco/diaryApp/ui/components/myco_snackbar.dart';

class CreateJournalScreen extends StatefulWidget {
  const CreateJournalScreen({Key? key}) : super(key: key);

  @override
  State<CreateJournalScreen> createState() => _CreateJournalScreenState();
}

class _CreateJournalScreenState extends State<CreateJournalScreen> {
  TextEditingController highlightController = TextEditingController();
  TextEditingController journalController = TextEditingController();

  final _addFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Journal')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            Form(
                key: _addFormKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: highlightController,
                        decoration:
                            const InputDecoration(hintText: 'Highlight'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter highlight text';
                          }
                          return null;
                        }),
                    TextFormField(
                        controller: journalController,
                        maxLines: 20,
                        decoration:
                            const InputDecoration(hintText: 'Add journal'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter highlight text';
                          }
                          return null;
                        }),
                  ],
                )),
            ElevatedButton(
                onPressed: () => addDiary(), child: const Text('Add Journal'))
          ],
        ),
      ),
    );
  }

  Future addDiary() async {
    if (_addFormKey.currentState!.validate()) {
      String message = "Added Journal successfully";
      try {
        String highlight = highlightController.text.trim();
        String journal = journalController.text.trim();
        Diary diary = Diary(
            journal: journal,
            highlight: highlight,
            date: DateTime.now().toString());

        DiaryRepository _diaryRepository = DiaryRepository();
        var response = await _diaryRepository.addJournal(diary);
        if (response != true) {
          message = '$response';
        } else {
          Navigator.pop(context);
        }
      } catch (e) {
        message = e.toString();
      }

      mycoSnackBar(context, message);
    }
  }
}
