import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthentication {
  Future<User?> authenticateAnonymously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      debugPrint("Signed in with temporary account.");
      final user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          debugPrint("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          debugPrint("Unknown error.");
      }
    }
    return null;
  }
}
