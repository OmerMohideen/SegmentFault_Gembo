import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:user_application/models/form_model.dart';
import 'package:user_application/models/visa_status_model.dart';
import 'package:user_application/utils/form_handler.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid uuid = Uuid();

  Future<String> _uploadFile(File file, String fileName) async {
    try {
      String fileExtension = path.extension(file.path);
      String uniqueFileName = "${uuid.v4()}_${fileName}${fileExtension}";
      final storageRef = _storage.ref().child("uploads/$uniqueFileName");
      final uploadTask = storageRef.putFile(file);
      final taskSnapshot = await uploadTask;
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading file: $e");
      throw e;
    }
  }

  Future<void> _createVisaStatus(String applicationId, String userId) async {
    final initialStatus = VisaStatus(
      statusCode: 0,
      statusMessage: "Application Submitted",
      author: "system",
      comments: "Initial submission of the application.",
      timestamp: null,
    );

    DocumentReference statusRef = _firestore
        .collection("users")
        .doc(userId)
        .collection("visa_applications")
        .doc(applicationId)
        .collection("visa_status")
        .doc(applicationId);

    await statusRef.collection("history").add(initialStatus.toJson());
  }

  Future<VisaStatus?> getCurrentVisaStatus(
      String applicationId, String userId) async {
    DocumentSnapshot snapshot = await _firestore
        .collection("users")
        .doc(userId)
        .collection("visa_applications")
        .doc(applicationId)
        .collection("visa_status")
        .doc(applicationId)
        .get();

    if (snapshot.exists) {
      return VisaStatus.fromJson(snapshot.data() as Map<String, dynamic>);
    }

    return null;
  }

  Future<List<VisaStatus>> getVisaStatusHistory(
      String applicationId, String userId) async {
    QuerySnapshot snapshot = await _firestore
        .collection("users")
        .doc(userId)
        .collection("visa_applications")
        .doc(applicationId)
        .collection("visa_status")
        .doc(applicationId)
        .collection("history")
        .orderBy("timestamp", descending: true)
        .get();

    return snapshot.docs
        .map((doc) => VisaStatus.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveFormData(FormHandler formHandler, String userId) async {
    final formFields = formHandler.getAllFields();
    final formFiles = formHandler.getAllFiles();

    Map<String, String?> fileUrls = {};

    for (String key in formFiles.keys) {
      final file = formFiles[key];
      if (file != null) {
        String downloadUrl = await _uploadFile(file, key);
        fileUrls[key] = downloadUrl;
      }
    }

    final formModel = FormModel(fields: formFields, fileUrls: fileUrls);

    DocumentReference docRef = await _firestore
        .collection("users")
        .doc(userId)
        .collection("visa_applications")
        .add(formModel.toJson());

    String documentId = docRef.id;

    await _createVisaStatus(documentId, userId);
  }
}
