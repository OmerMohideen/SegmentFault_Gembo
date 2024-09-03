import 'dart:io';

import 'package:flutter/material.dart';

class FormHandler with ChangeNotifier {
  final Map<String, String?> _fields = {};
  final Map<String, File?> _files = {};

  String? getFieldValue(String fieldKey) {
    return _fields[fieldKey];
  }

  void setFieldValue(String fieldKey, String? value) {
    _fields[fieldKey] = value;
    notifyListeners();
  }

  Map<String, String?> getAllFields() {
    return _fields;
  }

  File? getFile(String fieldKey) {
    return _files[fieldKey];
  }

  void setFile(String fieldKey, File file) {
    _files[fieldKey] = file;
    notifyListeners();
  }

  Map<String, File?> getAllFiles() {
    return _files;
  }
}
