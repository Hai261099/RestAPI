import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rest_api/models/api_response.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_for_listing.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/models/note_insert.dart';

class NotesService {
  final String api = 'https://5f802ba8d6aabe00166f1032.mockapi.io';
  Dio dio = Dio();

  Future<APIResponse<List<NoteForListing>>> getNoteList() async {
    var response = await dio.get(api + '/notes');
    if (response.statusCode == 200) {
      List<dynamic> data = await response.data;

      List<NoteForListing> notes =
          data.map((dynamic item) => NoteForListing.fromJson(item)).toList();

      return APIResponse<List<NoteForListing>>(data: notes);
    } else
      return APIResponse<List<NoteForListing>>(
          errorMessage: 'An error occured', error: true);
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

  Future<APIResponse<bool>> createNote(NoteManipulation item) {
    return http.post(api + '/notes', body: item.toJson()).then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(errorMessage: 'An error occured', error: true));
  }

  Future<APIResponse<bool>> updateNote(String noteID, NoteManipulation item) {
    return http.put(api + '/notes/' + noteID, body: item.toJson()).then((data) {
      if (data.statusCode == 200) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<Note>> deleteNote(String noteID) {
    return http.delete(api + '/notes/' + noteID).then((data) {
      print(data.statusCode);
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Note>(errorMessage: 'An error occured', error: true));
  }
}
