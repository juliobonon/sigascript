import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigascript/services/database.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> createUserWithEmailandPassword(
      String email, String user, String password);
  Stream<User> get authStateChanges;
  Future<void> signOut();
  Future getCurrentUser();
}

class Auth implements BaseAuth {
  Stream<User> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Logado";
    } catch (e) {
      return e.message;
    }
  }

  Future<String> createUserWithEmailandPassword(
      String email, String userName, String password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await DatabaseService(uid: user.user.uid).updateUserData(false, userName);
      return "Usuario cadastrado";
    } catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
