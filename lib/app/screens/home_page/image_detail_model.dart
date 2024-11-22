import 'package:cloud_firestore/cloud_firestore.dart';

class ImageDetailModel {
  final String text_box;
  final String image_box;
  final DateTime? timestamp;

  ImageDetailModel({
    required this.text_box,
    required this.image_box,
    this.timestamp,
  });

  // Convert from JSON (Firestore document) to ImageDetailModel
  factory ImageDetailModel.fromJson(Map<String, dynamic> json) {
    return ImageDetailModel(
      text_box: json['text_box'] ?? '',
      image_box: json['image_box'] ?? '',
      timestamp: (json['timestamp'] as Timestamp?)?.toDate(),
    );
  }

  // Convert from ImageDetailModel to JSON (for saving in Firestore)
  Map<String, dynamic> toJson() {
    return {
      'text_box': text_box,
      'image_box': image_box,
      'timestamp': FieldValue.serverTimestamp(),
    };
  }
}
