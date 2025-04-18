import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const String routeName = '/auth_screen';
  @override 
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECEF), // Тёплый серый фон
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Плейсхолдер для логотипа
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF4A90E2), // Мягкий синий
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'CS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Заголовок
              const Text(
                'ConnectSphere',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A2526), // Глубокий чёрный
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Войдите, чтобы начать общение',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF1A2526),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              // Кнопка Google
              ElevatedButton.icon(
                onPressed: () {
                  // Логика входа через Google будет добавлена позже
                },
                icon: Image.asset(
                  'assets/google_logo.png', // Добавьте иконку Google в assets
                  width: 24,
                  height: 24,
                ),
                label: const Text('Войти через Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF4A90E2), // Мягкий синий
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  elevation: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
