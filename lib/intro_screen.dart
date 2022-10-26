import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            Text(
              'تطبيق بطاقات الأحاديث',
              style: TextStyle(fontSize: 35, color: Colors.indigo[800]),
            ),
            const Spacer(flex: 2),
            const Text(
              'الإصدار  1.0.0\nنسخة تجريبية',
              style: TextStyle(
                fontSize: 17.5,
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
