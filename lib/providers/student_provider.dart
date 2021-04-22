import 'package:sigascript/models/student.dart';
import 'package:sigascript/services/database.dart';

class StudentProvider {
  final databaseService = DatabaseService();

  String _isSigaConfigured;
  String _user;
  String _rgSiga;
  String _sigaPassword;

  String get isSigaConfigured => _isSigaConfigured;
  String get user => _user;
  String get rgSiga => _rgSiga;
  String get sigaPassword => _sigaPassword;

  Stream<Student> get data => databaseService.getStudentData();
}
