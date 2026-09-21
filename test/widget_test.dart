import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sante_proche/main.dart';

void main() {
  testWidgets('construit l application', (tester) async {
    await tester.pumpWidget(const SanteProcheApp());
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
