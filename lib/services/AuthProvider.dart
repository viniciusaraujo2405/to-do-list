import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners(); // Notifica os ouvintes sobre a mudança de estado.
    } on FirebaseAuthException catch (e) {
      throw e; // Lança a exceção para ser tratada na UI.
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Armazena o nome de usuário no Firestore.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': username,
        'email': email,
      });

      notifyListeners(); // Notifica os ouvintes sobre a mudança de estado.
    } on FirebaseAuthException catch (e) {
      throw e; // Lança a exceção para ser tratada na UI.
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado.
  }
}