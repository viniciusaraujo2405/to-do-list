import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TaskProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTask(String task) async {
    try {
      await _firestore.collection('tasks').add({
        'userId': _auth.currentUser!.uid,
        'task': task,
        'completed': false,
        'timestamp': FieldValue.serverTimestamp(),
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateTask(String taskId, String newTask) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'task': newTask,
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool completed) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'completed': !completed,
      });
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Stream<QuerySnapshot> get tasksStream {
    return _firestore
        .collection('tasks')
        .where('userId', isEqualTo: _auth.currentUser!.uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }
}