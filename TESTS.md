# Preuves de tests

## Tests automatisés

Commande exécutée :

```bash
dart analyze lib test
flutter test
```

Résultat : aucune erreur d’analyse et 3 tests réussis.

Les tests vérifient :

- la conversion des établissements, services et rendez-vous depuis les données Firebase ;
- le préremplissage de l’établissement et du service dans le formulaire ;
- le filtrage des hôpitaux et des dispensaires.

## Parcours manuel Firebase

1. Lancer l’application avec `flutter run`.
2. Vérifier que les établissements affichés correspondent à la collection `etablissement`.
3. Ouvrir un établissement et vérifier ses services dans la sous-collection `service`.
4. Ouvrir un service et vérifier le préremplissage du formulaire.
5. Envoyer le formulaire de rendez-vous.
6. Vérifier le nouveau document dans `rendez_vous`.
7. Ouvrir l’onglet Rendez-vous et vérifier l’affichage du document enregistré.

## Vérifications réalisées

- Navigation entre accueil, établissements, détail, service et rendez-vous : validée.
- Filtre hôpital et dispensaire : validé par test de widget.
- Enregistrement et lecture des rendez-vous Firebase : validé manuellement.
- APK debug déjà présent dans `build/app/outputs/flutter-apk/app-debug.apk`.
