import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/pages/note_list.dart';
import 'package:rest_api/services/notes_service.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => NotesService());
  // GetIt.instance<NotesService>();
}

void main() {
  setupLocator();
  runApp(MaterialApp(home: NoteList()));
}
