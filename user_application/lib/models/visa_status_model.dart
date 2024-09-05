import 'package:cloud_firestore/cloud_firestore.dart';

class VisaStatus {
  final int statusCode;
  final String statusMessage;
  final Timestamp? timestamp;
  final String author;
  final String? comments;

  VisaStatus({
    required this.statusCode,
    required this.statusMessage,
    this.timestamp,
    required this.author,
    this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      "status_code": statusCode,
      "status_message": statusMessage,
      "timestamp": timestamp ?? FieldValue.serverTimestamp(),
      "author": author,
      "comments": comments,
    };
  }

  factory VisaStatus.fromJson(Map<String, dynamic> json) {
    return VisaStatus(
      statusCode: json["status_code"],
      statusMessage: json["status_message"],
      timestamp: json["timestamp"],
      author: json["author"],
      comments: json["comments"],
    );
  }
}
