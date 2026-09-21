import 'package:flutter/material.dart';
import '../models/establishment_model.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';
import '../widgets/establishment_card.dart';

class HomeScreen extends StatelessWidget {
  final List<EstablishmentModel> establishments;
  final ValueChanged<EstablishmentModel> onOpenEstablishment;
  final VoidCallback onSeeAll;
  const HomeScreen({
    super.key,
    required this.establishments,
    required this.onOpenEstablishment,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const AppLogo(),
              CircleAvatar(
                backgroundColor: AppTheme.paleBlue,
                child: Icon(Icons.person, color: AppTheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF6FBFC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.search),
                hintText: 'Rechercher un établissement, un service...',
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 148,
            padding: const EdgeInsets.fromLTRB(18, 18, 8, 8),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8FB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bonjour !',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Votre santé nous tient à cœur.\nTrouvez facilement un établissement\nde santé proche de vous.',
                        style: TextStyle(fontSize: 12, height: 1.35),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/doctor.png',
                  width: 108,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const _Category(
                icon: Icons.local_hospital_outlined,
                label: 'Hôpitaux',
              ),
              const _Category(
                icon: Icons.home_work_outlined,
                label: 'Dispensaires',
              ),
              const _Category(
                icon: Icons.health_and_safety_outlined,
                label: 'Spécialités',
              ),
              const _Category(
                icon: Icons.emergency_outlined,
                label: 'Urgences',
              ),
            ],
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Établissements proches',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              TextButton(onPressed: onSeeAll, child: const Text('Voir tout')),
            ],
          ),
          const SizedBox(height: 6),
          ...establishments
              .take(2)
              .map(
                (item) => EstablishmentCard(
                  establishment: item,
                  compact: true,
                  onTap: () => onOpenEstablishment(item),
                ),
              ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF9FC),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Des soins aujourd’hui\npour un meilleur demain',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.darkBlue,
                    ),
                  ),
                ),
                Icon(Icons.local_florist, size: 52, color: AppTheme.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Category extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Category({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.paleBlue,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: AppTheme.primary),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 10, color: AppTheme.darkBlue),
        ),
      ],
    ),
  );
}
