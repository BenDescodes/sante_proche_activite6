import 'package:flutter/material.dart';
import '../models/establishment_model.dart';
import '../models/service_model.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'appointment_screen.dart';

class ServiceDetailScreen extends StatelessWidget {
  final ServiceModel service;
  final EstablishmentModel establishment;
  const ServiceDetailScreen({
    super.key,
    required this.service,
    required this.establishment,
  });
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Détail service'),
      actions: const [Icon(Icons.favorite_border), SizedBox(width: 14)],
    ),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Image.asset(
          'assets/images/pediatrics.png',
          height: 220,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.nom,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 14),
              Text(
                service.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.paleBlue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Services inclus',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.darkBlue,
                      ),
                    ),
                    SizedBox(height: 10),
                    _CheckLine(text: 'Consultations spécialisées'),
                    _CheckLine(text: 'Suivi et conseils personnalisés'),
                    _CheckLine(text: 'Prise en charge adaptée'),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              PrimaryButton(
                label: 'Demander un rendez-vous',
                icon: Icons.event_available,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AppointmentScreen(
                      establishment: establishment,
                      service: service,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _CheckLine extends StatelessWidget {
  final String text;
  const _CheckLine({required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      children: [
        const Icon(Icons.check_circle, size: 18, color: AppTheme.primary),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
