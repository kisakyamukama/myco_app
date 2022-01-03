import 'package:flutter/foundation.dart';

class Todo {
  int? id;
  //description is the text we see on
  //main screen card text
  String description;
  //isDone used to mark what Todo item is completed
  bool isDone = false;
  bool isSynchronized = false;
  //When using curly braces { } we note dart that
  //the parameters are optional
  Todo(
      {this.id,
      required this.description,
      this.isDone = false,
      this.isSynchronized = false});
  factory Todo.fromDatabaseJson(Map<String, dynamic> data) {
    return Todo(
      //This will be used to convert JSON objects that
      //are coming from querying the database and converting
      //it into a Todo object
      id: data['id'],
      description: data['description'],
      //Since sqlite doesn't have boolean type for true/false
      //we will 0 to denote that it is false
      //and 1 for true
      isDone: data['is_done'] == 0 ? false : true,
      isSynchronized: data['is_synched'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toDatabaseJson() => {
        //This will be used to convert Todo objects that
        //are to be stored into the datbase in a form of JSON
        "id": id,
        "description": description,
        "is_done": isDone == false ? 0 : 1,
        "is_synched": isSynchronized == false ? 0 : 1,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "is_done": isDone,
        "is_synched": isSynchronized,
      };
}
