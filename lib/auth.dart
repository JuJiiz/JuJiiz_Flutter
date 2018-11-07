import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);

  Future<String> createUserWithEmailAndPassword(String email, String password);

  Future<String> currentUser();

  void signOut();
}

class Auth implements BaseAuth {
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user.uid;
  }

  Future<String> createUserWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print('user: $user');

    return user.uid;
  }

  Future<String> currentUser() async {
    //String uid;
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    /*if (user != null) {
      uid = user.uid;
    }*/
    return user.uid;
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
