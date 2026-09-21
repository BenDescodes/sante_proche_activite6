import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sante_proche/models/appointment_model.dart';
import 'package:sante_proche/models/establishment_model.dart';
import 'package:sante_proche/models/service_model.dart';
import 'package:sante_proche/screens/appointment_screen.dart';
import 'package:sante_proche/screens/establishments_screen.dart';

void main() {
  final service = ServiceModel(
    id: 'service-1',
    nom: 'Soins intensifs',
    description: 'Prise en charge spécialisée.',
  );

  final hospital = EstablishmentModel(
    id: 'hospital-1',
    nom: 'Hôpital Général de Kinshasa',
    commune: 'Kalamu',
    description: 'Établissement hospitalier général.',
    horaires: '07h00 - 18h00',
    telephone: '+243 81 00 00 00',
    type: 'hopital',
    services: [service],
  );

  final dispensary = EstablishmentModel(
    id: 'dispensary-1',
    nom: 'Dispensaire Yolo Sud',
    commune: 'Kalamu',
    description: 'Centre de santé de proximité.',
    horaires: '08h00 - 16h00',
    telephone: '+243 82 00 00 00',
    type: 'dispensaire',
    services: const [],
  );

  test('construit les modèles depuis les données Firebase', () {
    final parsedService = ServiceModel.fromMap('service-1', {
      'nom': 'Pédiatrie',
      'description': 'Soins pour enfants',
    });
    final parsedEstablishment = EstablishmentModel.fromMap(
      'hospital-1',
      {
        'nom': 'Hôpital Général',
        'commune': 'Limete',
        'description': 'Description',
        'horaires': '24h/24',
        'telephone': '+243 81 00 00 00',
        'type': 'hopital',
      },
      [parsedService],
    );
    final appointment = AppointmentModel.fromMap('appointment-1', {
      'nom': 'Bonda',
      'prenom': 'Benjamin',
      'telephone': '+243 89 00 00 00',
      'etablissement': 'Hôpital Général',
      'service': 'Pédiatrie',
      'message': 'Consultation',
    });

    expect(parsedEstablishment.nom, 'Hôpital Général');
    expect(parsedEstablishment.services.single.nom, 'Pédiatrie');
    expect(appointment.firstName, 'Benjamin');
    expect(appointment.service, 'Pédiatrie');
  });

  testWidgets('préremplit le service et l établissement', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AppointmentScreen(establishment: hospital, service: service),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Soins intensifs'), findsOneWidget);
    expect(find.text('Hôpital Général de Kinshasa'), findsOneWidget);
  });

  testWidgets('filtre les hôpitaux et les dispensaires', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: EstablishmentsScreen(
            establishments: [hospital, dispensary],
            onOpen: (_) {},
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(hospital.nom), findsOneWidget);
    expect(find.text(dispensary.nom), findsOneWidget);

    await tester.tap(find.text('Hôpitaux'));
    await tester.pumpAndSettle();
    expect(find.text(hospital.nom), findsOneWidget);
    expect(find.text(dispensary.nom), findsNothing);

    await tester.tap(find.text('Dispensaires'));
    await tester.pumpAndSettle();
    expect(find.text(hospital.nom), findsNothing);
    expect(find.text(dispensary.nom), findsOneWidget);
  });
}
