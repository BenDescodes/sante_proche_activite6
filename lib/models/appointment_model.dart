import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String id;
  final String name;
  final String firstName;
  final String phone;
  final String establishment;
  final String service;
  final String message;
  final DateTime? createdAt;

  const AppointmentModel({
    required this.id,
    required this.name,
    required this.firstName,
    required this.phone,
    required this.establishment,
    required this.service,
    required this.message,
    required this.createdAt,
  });

  factory AppointmentModel.fromMap(String id, Map<String, dynamic> map) {
    final timestamp = map['createdAt'];
    return AppointmentModel(
      id: id,
      name: map['nom'] ?? '',
      firstName: map['prenom'] ?? '',
      phone: map['telephone'] ?? '',
      establishment: map['etablissement'] ?? '',
      service: map['service'] ?? '',
      message: map['message'] ?? '',
      createdAt: timestamp is Timestamp ? timestamp.toDate() : null,
    );
  }
}
