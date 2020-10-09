class Note {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  Note(
      {this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.lastEditDateTime});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        noteID: json['noteID'],
        noteTitle: json['noteTitle'],
        noteContent: json['noteContent'],
        createDateTime: DateTime.parse(json['createDateTime']),
        lastEditDateTime: json['lastEditDateTime'] != null
            ? DateTime.parse(json['lastEditDateTime'])
            : null);
  }
}
