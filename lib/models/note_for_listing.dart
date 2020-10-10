class NoteForListing {
  String noteID;
  String noteTitle;
  String noteContent;
  DateTime createDateTime;
  DateTime lastEditDateTime;

  NoteForListing({
    this.noteID,
    this.noteTitle,
    this.createDateTime,
    this.lastEditDateTime,
    this.noteContent,
  });

  factory NoteForListing.fromJson(Map<String, dynamic> json) {
    return NoteForListing(
      noteID: json['noteID'],
      noteTitle: json['noteTitle'],
      createDateTime: DateTime.parse(json['createDateTime']),
      lastEditDateTime: json['lastEditDateTime'] != null
          ? DateTime.parse(json['lastEditDateTime'])
          : null,
      noteContent: json['noteContent'],
    );
  }
}
