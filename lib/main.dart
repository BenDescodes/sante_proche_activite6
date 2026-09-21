import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'models/establishment_model.dart';
import 'screens/establishment_detail_screen.dart';
import 'screens/establishments_screen.dart';
import 'screens/home_screen.dart';
import 'screens/appointments_screen.dart';
import 'services/establishment_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (_) {}
  runApp(const SanteProcheApp());
}

class SanteProcheApp extends StatelessWidget {
  const SanteProcheApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Santé Proche',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.data,
    home: const AppShell(),
  );
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final service = EstablishmentService();
  int index = 0;
  late Future<List<EstablishmentModel>> establishments;
  @override
  void initState() {
    super.initState();
    establishments = service.getEstablishments();
  }

  @override
  Widget build(BuildContext context) => FutureBuilder<List<EstablishmentModel>>(
    future: establishments,
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Impossible de récupérer les établissements Firebase.\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      final items = snapshot.data!;
      final screens = [
        HomeScreen(
          establishments: items,
          onOpenEstablishment: _open,
          onSeeAll: () => setState(() => index = 1),
        ),
        EstablishmentsScreen(establishments: items, onOpen: _open),
        const AppointmentsScreen(),
        const Center(child: Text('Profil utilisateur')),
      ];
      return Scaffold(
        body: IndexedStack(index: index, children: screens),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (value) => setState(() => index = value),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Accueil',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_hospital_outlined),
              selectedIcon: Icon(Icons.local_hospital),
              label: 'Établissements',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month_outlined),
              selectedIcon: Icon(Icons.calendar_month),
              label: 'Rendez-vous',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      );
    },
  );
  void _open(EstablishmentModel item) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EstablishmentDetailScreen(establishment: item),
    ),
  );
}
