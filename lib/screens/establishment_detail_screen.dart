import 'package:flutter/material.dart';
import '../models/establishment_model.dart';
import '../models/service_model.dart';
import '../theme/app_theme.dart';
import 'service_detail_screen.dart';

class EstablishmentDetailScreen extends StatelessWidget {
  final EstablishmentModel establishment;
  const EstablishmentDetailScreen({super.key, required this.establishment});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(establishment.nom),
      actions: const [Icon(Icons.favorite_border), SizedBox(width: 14)],
    ),
    body: ListView(
      padding: const EdgeInsets.only(bottom: 24),
      children: [
        Image.asset(
          'assets/images/hospital.png',
          height: 210,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                establishment.nom,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(establishment.type),
                backgroundColor: AppTheme.paleBlue,
                side: BorderSide.none,
              ),
              const SizedBox(height: 8),
              _Info(icon: Icons.location_on, text: establishment.commune),
              if (establishment.telephone.isNotEmpty)
                _Info(icon: Icons.phone, text: establishment.telephone),
              const SizedBox(height: 12),
              Text(
                establishment.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _InfoBox(
                    icon: Icons.access_time,
                    title: 'Horaires',
                    value: establishment.horaires,
                  ),
                  const SizedBox(width: 12),
                  const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 22),
              Text(
                'Services proposés',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              ...establishment.services.map(
                (service) => _ServiceTile(
                  service: service,
                  establishment: establishment,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _Info extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Info({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      children: [
        Icon(icon, size: 17, color: AppTheme.primary),
        const SizedBox(width: 7),
        Text(text, style: const TextStyle(color: AppTheme.darkBlue)),
      ],
    ),
  );
}

class _InfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const _InfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.paleBlue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _ServiceTile extends StatelessWidget {
  final ServiceModel service;
  final EstablishmentModel establishment;
  const _ServiceTile({required this.service, required this.establishment});
  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const CircleAvatar(
      backgroundColor: AppTheme.paleBlue,
      child: Icon(Icons.medical_services_outlined, color: AppTheme.primary),
    ),
    title: Text(
      service.nom,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: AppTheme.darkBlue,
      ),
    ),
    trailing: const Icon(Icons.chevron_right, color: AppTheme.primary),
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ServiceDetailScreen(service: service, establishment: establishment),
      ),
    ),
  );
}
