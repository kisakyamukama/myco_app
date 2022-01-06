
import 'package:flutter/material.dart';
import 'package:myco/diaryApp/core/model/model.dart';

class JournalDisplay extends StatelessWidget {
  const JournalDisplay({
    Key? key,
    required this.journal,
  }) : super(key: key);

  final Diary journal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Card(
        child: Column(
          children: [
            Text('${journal.highlight}'),
            SizedBox(height:8.0),
            Text('${journal.journal}',maxLines: 3, style: TextStyle(),),
          ],
        ),
      ),
    );
  }
}
