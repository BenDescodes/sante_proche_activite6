import 'package:flutter/material.dart';
import '../models/establishment_model.dart';
import '../models/service_model.dart';
import '../services/establishment_service.dart';
import '../widgets/primary_button.dart';
import 'confirmation_screen.dart';

class AppointmentScreen extends StatefulWidget {
  final EstablishmentModel? establishment;
  final ServiceModel? service;
  const AppointmentScreen({super.key, this.establishment, this.service});
  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final firstName = TextEditingController();
  final phone = TextEditingController();
  final message = TextEditingController();
  bool loading = false;
  String service = '';
  String establishment = '';
  @override
  void initState() {
    super.initState();
    service = widget.service?.nom ?? '';
    establishment = widget.establishment?.nom ?? '';
  }

  @override
  void dispose() {
    name.dispose();
    firstName.dispose();
    phone.dispose();
    message.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    if (!formKey.currentState!.validate() ||
        service.isEmpty ||
        establishment.isEmpty) {
      return;
    }
    setState(() => loading = true);
    await EstablishmentService().createAppointment(
      name: name.text,
      firstName: firstName.text,
      phone: phone.text,
      establishment: establishment,
      service: service,
      message: message.text,
    );
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ConfirmationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Demande de rendez-vous')),
    body: Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _field('Nom *', name, 'Votre nom'),
          _field('Prénom *', firstName, 'Votre prénom'),
          _field(
            'Numéro de téléphone *',
            phone,
            '+243 81 23 45 67',
            keyboard: TextInputType.phone,
          ),
          _selector('Service demandé *', service, [
            'Médecine générale',
            'Pédiatrie',
            'Maternité',
            'Urgences',
          ], (value) => setState(() => service = value)),
          _selector(
            'Établissement *',
            establishment,
            [
              establishment.isEmpty
                  ? 'Sélectionner un établissement'
                  : establishment,
            ],
            (value) => setState(() => establishment = value),
          ),
          TextFormField(
            controller: message,
            maxLines: 4,
            decoration: const InputDecoration(
              labelText: 'Message (optionnel)',
              hintText: 'Informations complémentaires...',
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: loading ? 'Envoi...' : 'Envoyer la demande',
            icon: Icons.send,
            onPressed: loading ? () {} : submit,
          ),
        ],
      ),
    ),
  );
  Widget _field(
    String label,
    TextEditingController controller,
    String hint, {
    TextInputType? keyboard,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboard,
      validator: (value) =>
          value == null || value.isEmpty ? 'Ce champ est obligatoire' : null,
      decoration: InputDecoration(labelText: label, hintText: hint),
    ),
  );
  Widget _selector(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    final options = {...values, if (value.isNotEmpty) value}.toList();
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: DropdownButtonFormField<String>(
        initialValue: value.isEmpty ? null : value,
        validator: (value) =>
            value == null || value.isEmpty ? 'Sélectionnez une option' : null,
        decoration: InputDecoration(labelText: label),
        items: options
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (item) {
          if (item != null) onChanged(item);
        },
      ),
    );
  }
}
