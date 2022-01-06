import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myco/diaryApp/core/model/model.dart';
import 'package:myco/diaryApp/core/repository/repository.dart';

class DiaryRepository {
  final DiaryRemoteRepository _diaryRemoteRepository = DiaryRemoteRepository();

  Future addJournal(Diary diary) async {
    var response = await _diaryRemoteRepository.addJournal(diary.toJson());
    debugPrint(response.body);
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Response status code:  ${response.statusCode} \n response  body:  ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Diary>> getJournals() async {
    List<Diary> journals = [];
    var response = await _diaryRemoteRepository.getJournals();
    debugPrint(response.body);
    try {
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        journals =
            json.map((data) => Diary.fromJson(data)).cast<Diary>().toList();
      } else {
        throw Exception(
            'Response status code:  ${response.statusCode} \n response  body:  ${response.body}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
    return journals;
  }
}
