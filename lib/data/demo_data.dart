import '../models/establishment_model.dart';
import '../models/service_model.dart';

const demoServices = [
  ServiceModel(
    id: 'medecine',
    nom: 'Médecine générale',
    description: 'Consultations médicales générales et suivi de santé.',
  ),
  ServiceModel(
    id: 'pediatrie',
    nom: 'Pédiatrie',
    description: 'Prise en charge médicale des enfants et des nourrissons.',
  ),
  ServiceModel(
    id: 'maternite',
    nom: 'Maternité',
    description: 'Suivi de grossesse, accouchement et soins postnataux.',
  ),
  ServiceModel(
    id: 'urgences',
    nom: 'Urgences',
    description: 'Prise en charge rapide des situations urgentes.',
  ),
];

final demoEstablishments = [
  EstablishmentModel(
    id: 'demo-1',
    nom: 'Hôpital Saint Joseph',
    commune: 'Limete',
    description: 'Un établissement de proximité pour toute la famille.',
    horaires: '24h/24',
    telephone: '+243 81 72 33 44',
    type: 'Hôpital général',
    services: demoServices,
  ),
  EstablishmentModel(
    id: 'demo-2',
    nom: 'Centre Médical Sainte-Marie',
    commune: 'Gombe',
    description: 'Des soins spécialisés dans un cadre accueillant.',
    horaires: 'Lun - Ven, 7h - 17h',
    telephone: '+243 81 72 33 45',
    type: 'Clinique',
    services: demoServices.sublist(0, 3),
  ),
  EstablishmentModel(
    id: 'demo-3',
    nom: 'Dispensaire de Nzeng-Ayong',
    commune: 'Ngaliema',
    description: 'Des consultations accessibles proches de chez vous.',
    horaires: 'Lun - Sam, 8h - 16h',
    telephone: '+243 81 72 33 46',
    type: 'Dispensaire',
    services: demoServices.sublist(0, 2),
  ),
];
