import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigascript/models/student.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(bool siga, String user) async {
    return await usersCollection.doc(uid).set(
      {
        'isSigaConfigured': false,
        'user': user,
        'rgSiga': null,
        'sigaPassword': null,
      },
    );
  }

  Student _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Student(
        isSigaConfigured: snapshot.data()['isSigaConfigured'],
        rgSiga: snapshot.data()['rgSiga'],
        sigaPassword: snapshot.data()['sigaPassword'],
        user: snapshot.data()['user']);
  }

  Stream<DocumentSnapshot> getStudentData(String useruid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .snapshots();
  }
}
