import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.paleBlue,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    size: 100,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Demande envoyée !',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Votre demande de rendez-vous a été envoyée avec succès. Vous serez contacté par l’établissement pour la date et l’heure de votre rendez-vous.',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  label: 'Retour à l’accueil',
                  icon: Icons.home,
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
