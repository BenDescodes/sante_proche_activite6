import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/establishment_model.dart';
import '../models/service_model.dart';
import '../models/appointment_model.dart';

class EstablishmentService {
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<List<EstablishmentModel>> getEstablishments() async {
    try {
      final snapshot = await _firestore.collection('etablissement').get();
      if (snapshot.docs.isEmpty) return [];

      final result = <EstablishmentModel>[];
      for (final document in snapshot.docs) {
        var services = <ServiceModel>[];
        try {
          final servicesSnapshot = await document.reference
              .collection('service')
              .get();
          services = servicesSnapshot.docs
              .map(
                (service) => ServiceModel.fromMap(service.id, service.data()),
              )
              .toList();
        } catch (_) {}
        result.add(
          EstablishmentModel.fromMap(document.id, document.data(), services),
        );
      }
      return result;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> createAppointment({
    required String name,
    required String firstName,
    required String phone,
    required String establishment,
    required String service,
    required String message,
  }) async {
    try {
      await _firestore.collection('rendez_vous').add({
        'nom': name,
        'prenom': firstName,
        'telephone': phone,
        'etablissement': establishment,
        'service': service,
        'message': message,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (_) {}
  }

  Future<List<AppointmentModel>> getAppointments() async {
    final snapshot = await _firestore.collection('rendez_vous').get();
    final appointments = snapshot.docs
        .map(
          (document) => AppointmentModel.fromMap(document.id, document.data()),
        )
        .toList();
    appointments.sort((a, b) {
      final first = a.createdAt ?? DateTime(2000);
      final second = b.createdAt ?? DateTime(2000);
      return second.compareTo(first);
    });
    return appointments;
  }
}
