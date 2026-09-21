class ServiceModel {
  final String id;
  final String nom;
  final String description;

  const ServiceModel({
    required this.id,
    required this.nom,
    required this.description,
  });

  factory ServiceModel.fromMap(String id, Map<String, dynamic> map) {
    return ServiceModel(
      id: id,
      nom: map['nom'] ?? 'Service médical',
      description: map['description'] ?? '',
    );
  }
}
