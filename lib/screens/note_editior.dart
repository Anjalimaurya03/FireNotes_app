import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
   const  NoteEditorScreen({Key? key}) : super(key: key);


  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}



class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(AppStyle.cardsColor.length);
  String date =  DateTime.now().toString();

  late TextEditingController _mainController;
  late TextEditingController _titleController;
  @override
  void initState(){
    super.initState();
    _titleController = TextEditingController();
    _mainController = TextEditingController();
  }
  @override
  void dispose() {
    _titleController.dispose();
    _mainController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppStyle.cardsColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
            'Add New Note',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',

              ),
              style: AppStyle.mainTitle,
            ),
            const SizedBox(height: 8.0,),
            Text(date, style: AppStyle.dateTitle,),

            const SizedBox(height: 28.0,),

            TextField(
              controller: _mainController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note content',

              ),
              style: AppStyle.mainContent,
            ),

          ],
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppStyle.accentColor,
        onPressed: () async {
          try {
            var catchError = await FirebaseFirestore.instance.collection('Notes').add({
              'note_title': _titleController.text,
              'creation_date': date,
              'note_content': _mainController.text, // Corrected note content
              'color_id': color_id, // Add color_id to Firestore
            });

            print('New note added with ID: ${catchError.id}');
            Navigator.pop(context);
          } catch (error) {
            print('Failed to add new note: $error');
          }
        },
        child: Icon(Icons.save),
      ),


    );
  }
}


