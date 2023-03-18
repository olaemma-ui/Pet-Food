import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:pet_food/Service/notification.manager.dart';

class DatabaseService {
  // static final _firebaseStorage = ;
  static final _firebaseStorage = FirebaseStorage.instance;

  static final foodCollection = FirebaseFirestore.instance.collection('food');

  static Future<void> uploadFood(
      {required File file, required String fileName}) async {
    try {
      final ref = _firebaseStorage.ref().child('files/$fileName');
      await ref.putFile(file);
      await NotificationManager.showNotification(
          'Thank you for sharing food with me');
      Get.offAndToNamed('/final');
    } catch (_) {
      await NotificationManager.showNotification('Failed to send food');
    }
  }
}
