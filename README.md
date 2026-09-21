# Santé Proche

## Objectif

Santé Proche aide les utilisateurs à trouver un établissement de santé, consulter ses services et envoyer une demande de rendez-vous.

## Fonctionnalités principales

- Affichage des établissements depuis Cloud Firestore
- Recherche et filtrage par hôpital ou dispensaire
- Consultation du détail d’un établissement et de ses services
- Formulaire de rendez-vous avec établissement et service préremplis
- Enregistrement et affichage des rendez-vous depuis Firestore
- Écran de confirmation après l’envoi

## Technologies

- Flutter et Dart
- Firebase Core
- Cloud Firestore
- Gestion d’état avec `setState` et `FutureBuilder`

## Structure

```text
lib/
  main.dart
  models/
  screens/
  services/
  theme/
  widgets/
assets/images/
test/
```

## Données Firebase

La collection `etablissement` contient les établissements. Chaque établissement peut contenir une sous-collection `service`.

La collection `rendez_vous` contient les demandes envoyées avec les champs `nom`, `prenom`, `telephone`, `etablissement`, `service`, `message` et `createdAt`.

## Installation

```bash
flutter pub get
```

Le fichier Android Firebase doit être présent dans `android/app/google-services.json`.

## Lancement

```bash
flutter run
```

## Tests

```bash
dart analyze lib test
flutter test
```

Les tests vérifient la conversion des données Firebase, le préremplissage du formulaire de rendez-vous et les filtres des établissements.

## Version installable

```bash
flutter build apk --debug
```

L’APK est généré dans `build/app/outputs/flutter-apk/app-debug.apk`.

## Difficultés rencontrées

## Captures d’écran

## Auteur

Benjamin Bonda
