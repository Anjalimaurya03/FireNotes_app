import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/screens/note_editior.dart';
import 'package:to_do_app/screens/note_reader.dart';
import 'package:to_do_app/style/app_style.dart';
import 'package:to_do_app/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.bgColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("TO-DO",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: AppStyle.bgColor
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Recent Notes',
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),


            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Notes').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasData) {
                    final noteDocs = snapshot.data!.docs;
                    return SingleChildScrollView(
                      child: Scrollbar(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemCount: noteDocs.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final note = noteDocs[index];
                            return noteCard(
                                  () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NoteReaderScreen(note),
                                  ),
                                );
                              },
                              note,
                            );
                          },
                        ),
                      ),
                    );
                  }

                  return Text(
                    "There's no notes",
                    style: GoogleFonts.nunito(color: Colors.white),
                  );
                },
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => NoteEditorScreen()
              ));
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
