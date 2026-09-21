import 'package:flutter_test/flutter_test.dart';
import 'package:sante_proche/models/service_model.dart';

void main() {
  test('ServiceModel.fromMap transforme les données Firebase', () {
    final service = ServiceModel.fromMap('service-1', {
      'nom': 'Pédiatrie',
      'description': 'Prise en charge médicale des enfants',
    });

    expect(service.id, 'service-1');
    expect(service.nom, 'Pédiatrie');
    expect(service.description, 'Prise en charge médicale des enfants');
  });

  test('ServiceModel.fromMap utilise les valeurs par défaut', () {
    final service = ServiceModel.fromMap('service-2', {});

    expect(service.id, 'service-2');
    expect(service.nom, 'Service médical');
    expect(service.description, isEmpty);
  });
}
