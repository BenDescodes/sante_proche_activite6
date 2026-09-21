import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({super.key, this.size = 34});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(size * .35),
          ),
          child: Icon(Icons.add, color: Colors.white, size: size * .68),
        ),
        const SizedBox(width: 9),
        Text(
          'Santé Proche',
          style: TextStyle(
            fontSize: size * .55,
            fontWeight: FontWeight.w800,
            color: AppTheme.darkBlue,
          ),
        ),
      ],
    );
  }
}
