import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rest_api/models/note.dart';
import 'package:rest_api/models/note_insert.dart';
import 'package:rest_api/services/notes_service.dart';

class NoteModify extends StatefulWidget {
  final String noteID;
  NoteModify({this.noteID});

  @override
  _NoteModifyState createState() => _NoteModifyState();
}

class _NoteModifyState extends State<NoteModify> {
  bool get isEditing => widget.noteID == null;

  NotesService get notesService => GetIt.I<NotesService>();

  String errorMessage;
  Note note;

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    if (!isEditing) {
      setState(() {
        _isLoading = true;
      });
      notesService.getNote(widget.noteID).then((response) {
        if (response.error) {
          setState(() {
            _isLoading = false;
          });
          errorMessage = response.errorMessage ?? 'An error occured';
        }
        note = response.data;
        _titleController.text = note.noteTitle;
        _contentController.text = note.noteContent;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(isEditing ? 'Create note' : 'Edit note')),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                      ),
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(hintText: 'Note Content'),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      height: 35,
                      child: RaisedButton(
                        child: Text('Submit',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.blue,
                        onPressed: () async {
                          if (!isEditing) {
                          } else {
                            setState(() {
                              _isLoading = true;
                            });
                            final note = NoteInsert(
                                noteTitle: _titleController.text,
                                noteContent: _contentController.text);
                            final result = await notesService.createNote(note);

                            setState(() {
                              _isLoading = false;
                            });
                            final title = 'Done';
                            final text = result.error
                                ? (result.errorMessage ?? 'An error occured')
                                : 'Your note was created';

                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Text(title),
                                      content: Text(text),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    )).then((data) {
                              if (result.data) {
                                Navigator.of(context).pop();
                              }
                            });
                          }
                        },
                      ),
                    )
                  ],
                ),
        ));
  }
}
