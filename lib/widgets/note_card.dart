import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  // Make sure to use correct field names and data types
  String noteTitle = doc['note_title'] as String;
  String creationDate = doc['creation_date'] as String;
  String noteContent = doc['note_content'].toString();
  int colorId = doc['color_id'] ; // Assuming 'color_id' is stored as int

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[colorId], // Use 'colorId'
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noteTitle,
            style: AppStyle.mainTitle,
          ),
          const SizedBox(
            height: 14.0,
          ),
          Text(
            creationDate,
            style: AppStyle.dateTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 28.0,
          ),
          Flexible(
            child: Text(
              noteContent,
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    ),
  );
}
