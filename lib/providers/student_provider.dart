import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigascript/services/database.dart';

class StudentProvider {
  var userData = FirebaseAuth.instance.currentUser.uid;
  final databaseService = DatabaseService();

  String _isSigaConfigured;
  String _user;
  String _rgSiga;
  String _sigaPassword;

  String get isSigaConfigured => _isSigaConfigured;
  String get user => _user;
  String get rgSiga => _rgSiga;
  String get sigaPassword => _sigaPassword;

  Stream<DocumentSnapshot> get data => databaseService.getStudentData(userData);
}
