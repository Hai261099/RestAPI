class NoteForListing {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing(
      {this.noteID,
      this.noteTitle,
      this.noteContent,
      this.createDateTime,
      this.lastEditDateTime});

  factory NoteForListing.fromJson(Map<String, dynamic> json) {
    return NoteForListing(
        noteID: json['noteID'],
        noteTitle: json['noteTitle'],
        noteContent: json['noteContent'],
        createDateTime: DateTime.parse(json['createDateTime']),
        lastEditDateTime: json['lastEditDateTime'] != null
            ? DateTime.parse(json['lastEditDateTime'])
            : null);
  }
}
