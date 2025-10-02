import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfileEntity {
  final String uid;
  final String name;
  final String email;
  final String? phoneNumber;
  final String? address;

  const UserProfileEntity({
    required this.uid,
    required this.name,
    required this.email,
    this.phoneNumber,
    this.address,
  });

  // Convert from Firebase User (for sign-in)
  factory UserProfileEntity.fromFirebaseUser (User user) {
    return UserProfileEntity(
      uid: user.uid,
      name: user.displayName ?? 'Unknown User', // Fallback if no name
      email: user.email ?? '',
      phoneNumber: user.phoneNumber,
      address: null, // Fetch/complete later
    );
  }

  // To JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'createdAt': FieldValue.serverTimestamp(), // Auto-timestamp
    };
  }

  // From JSON (Firestore doc)
  factory UserProfileEntity.fromJson(Map<String, dynamic> json) {
    return UserProfileEntity(
      uid: json['uid'] ?? '',
      name: json['name'] ?? 'Unknown User',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      address: json['address'],
    );
  }
}