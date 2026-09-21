import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../services/establishment_service.dart';
import '../theme/app_theme.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late Future<List<AppointmentModel>> appointments;

  @override
  void initState() {
    super.initState();
    appointments = EstablishmentService().getAppointments();
  }

  void refresh() {
    setState(() {
      appointments = EstablishmentService().getAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<List<AppointmentModel>>(
        future: appointments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return _Message(
              text: 'Impossible de récupérer les rendez-vous Firebase.',
              action: refresh,
            );
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return _Message(
              text: 'Aucun rendez-vous pour le moment.',
              action: refresh,
            );
          }
          return RefreshIndicator(
            onRefresh: () async => refresh(),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mes rendez-vous',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                      onPressed: refresh,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ...items.map((item) => _AppointmentCard(appointment: item)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  const _AppointmentCard({required this.appointment});

  @override
  Widget build(BuildContext context) {
    final date = appointment.createdAt == null
        ? 'Date non disponible'
        : '${appointment.createdAt!.day.toString().padLeft(2, '0')}/${appointment.createdAt!.month.toString().padLeft(2, '0')}/${appointment.createdAt!.year}';
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Color(0xFFE3F0F4)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: AppTheme.paleBlue,
                  child: Icon(Icons.calendar_month, color: AppTheme.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    appointment.service.isEmpty
                        ? 'Rendez-vous médical'
                        : appointment.service,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(fontSize: 11, color: Colors.blueGrey),
                ),
              ],
            ),
            const Divider(height: 24),
            _Line(
              icon: Icons.person_outline,
              text: '${appointment.firstName} ${appointment.name}',
            ),
            _Line(icon: Icons.phone_outlined, text: appointment.phone),
            _Line(
              icon: Icons.local_hospital_outlined,
              text: appointment.establishment,
            ),
            if (appointment.message.isNotEmpty)
              _Line(icon: Icons.notes_outlined, text: appointment.message),
          ],
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Line({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppTheme.primary),
        const SizedBox(width: 8),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class _Message extends StatelessWidget {
  final String text;
  final VoidCallback action;
  const _Message({required this.text, required this.action});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, textAlign: TextAlign.center),
          const SizedBox(height: 14),
          OutlinedButton.icon(
            onPressed: action,
            icon: const Icon(Icons.refresh),
            label: const Text('Actualiser'),
          ),
        ],
      ),
    ),
  );
}
