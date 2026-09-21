import 'package:flutter/material.dart';
import '../models/establishment_model.dart';
import '../theme/app_theme.dart';
import '../widgets/establishment_card.dart';

class EstablishmentsScreen extends StatefulWidget {
  final List<EstablishmentModel> establishments;
  final ValueChanged<EstablishmentModel> onOpen;

  const EstablishmentsScreen({
    super.key,
    required this.establishments,
    required this.onOpen,
  });

  @override
  State<EstablishmentsScreen> createState() => _EstablishmentsScreenState();
}

class _EstablishmentsScreenState extends State<EstablishmentsScreen> {
  String query = '';
  String filter = 'Tous';

  String normalize(String value) {
    return value
        .toLowerCase()
        .replaceAll('é', 'e')
        .replaceAll('è', 'e')
        .replaceAll('ê', 'e')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.establishments.where((item) {
      final text = '${item.nom} ${item.commune} ${item.type}'.toLowerCase();
      final matchesQuery = text.contains(query.toLowerCase());
      final type = normalize(item.type);
      final isHospital =
          type == 'hospital' ||
          type == 'hopital' ||
          type == 'hopitaux' ||
          type.contains('hospital');
      final isDispensary = type.contains('dispensaire');
      final matchesFilter =
          filter == 'Tous' ||
          (filter == 'Hôpitaux' && isHospital) ||
          (filter == 'Dispensaires' && isDispensary);
      return matchesQuery && matchesFilter;
    }).toList();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  'Établissements',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Rechercher un établissement...',
              ),
            ),
          ),
          const SizedBox(height: 13),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: ['Tous', 'Hôpitaux', 'Dispensaires'].map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(item),
                    selected: filter == item,
                    selectedColor: AppTheme.primary,
                    labelStyle: TextStyle(
                      color: filter == item ? Colors.white : AppTheme.darkBlue,
                    ),
                    onSelected: (_) => setState(() => filter = item),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: items.isEmpty
                ? const Center(child: Text('Aucun établissement trouvé.'))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: items.length,
                    itemBuilder: (_, index) => EstablishmentCard(
                      establishment: items[index],
                      onTap: () => widget.onOpen(items[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
