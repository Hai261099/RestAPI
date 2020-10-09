import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rest_api/models/api_response.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/note_insert.dart';

class NotesService {
  static const api = 'https://5f7ed868094b670016b769d2.mockapi.io';

  Future<APIResponse<List<NoteForListing>>> getNoteList() {
    return http.get(api + '/notes').then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final notes = <NoteForListing>[];
        for (var item in jsonData) {
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<NoteForListing>>(
        errorMessage: 'An error occured', error: true));
  }

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(api + '/notes/' + noteID).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Note>(errorMessage: 'An error occured', error: true));
  }

  Future<APIResponse<bool>> createNote(NoteInsert item) {
    return http.post(api + '/notes', body: item.toJson()).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(errorMessage: 'An error occured', error: true));
  }
}
