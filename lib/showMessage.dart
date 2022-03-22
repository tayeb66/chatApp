import 'package:chatapp/chatScreen_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowMessagePage extends StatelessWidget {
  const ShowMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('siam')
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            QueryDocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
            return ListTile(
              title: Column(
                crossAxisAlignment: loginUser!.email == documentSnapshot['user']
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: loginUser!.email == documentSnapshot['user']
                          ? Colors.blue
                          : Colors.deepOrange,
                      // border: Border.all(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      documentSnapshot['message'],
                      textScaleFactor: 1.3,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: loginUser!.email == documentSnapshot['user']
                              ? Colors.white
                              : Colors.white),
                    ),
                  ),
                  Text(
                    documentSnapshot['user'],
                    style: TextStyle(color: Colors.black26),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
