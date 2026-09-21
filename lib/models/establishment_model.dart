import 'service_model.dart';

class EstablishmentModel {
  final String id;
  final String nom;
  final String commune;
  final String description;
  final String horaires;
  final String telephone;
  final String type;
  final List<ServiceModel> services;

  const EstablishmentModel({
    required this.id,
    required this.nom,
    required this.commune,
    required this.description,
    required this.horaires,
    required this.telephone,
    required this.type,
    required this.services,
  });

  factory EstablishmentModel.fromMap(
    String id,
    Map<String, dynamic> map,
    List<ServiceModel> services,
  ) {
    return EstablishmentModel(
      id: id,
      nom: map['nom'] ?? 'Établissement de santé',
      commune: map['commune'] ?? 'Kinshasa',
      description: map['description'] ?? '',
      horaires: map['horaires'] ?? '24h/24',
      telephone: map['telephone'] ?? '',
      type: map['type'] ?? 'Hôpital',
      services: services,
    );
  }
}
