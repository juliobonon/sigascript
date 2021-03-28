import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference promoCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(bool siga, String user) async {
    return await promoCollection.doc(uid).set({
      'isSigaConfigured': false,
      'user': user,
    });
  }

  Stream<QuerySnapshot> get promos {
    return promoCollection.snapshots();
  }
}
