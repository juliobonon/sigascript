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

  Stream<Student> getStudentData() {
    var userId = FirebaseAuth.instance.currentUser.uid;
    var doc = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => Student.fromJson(snapshot.data()));

    return doc;
  }
}
