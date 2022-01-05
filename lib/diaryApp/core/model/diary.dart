class Diary {
  int? id;
  String journal;
  String highlight;
  String date;
  bool isSynchronized = false;

  Diary(
      {this.id,
      required this.journal,
      required this.highlight,
      required this.date,
      this.isSynchronized = false});
  factory Diary.fromDatabaseJson(Map<String, dynamic> data) {
    return Diary(
      id: data['id'],
      journal: data['journal'],
      date: data['date'],
      highlight: data['highlight'],
      isSynchronized: data['is_synched'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toDatabaseJson() => {
        "id": id,
        "journal": journal,
        "highlight": highlight,
        "date": date,
        "is_synched": isSynchronized == false ? 0 : 1,
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "journal": journal,
        "highlight": highlight,
        "date": date,
        "is_synched": isSynchronized,
      };
}
