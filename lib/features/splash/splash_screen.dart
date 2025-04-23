import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:video_desktop_saver/features/keyboard/presentation/keyboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();

    // Ждём завершения всей цепочки анимаций (~2.8s) и переходим
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (!_hasNavigated && mounted) {
        _hasNavigated = true;
        context.go(KeyboardScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/app_icon.png',
          width: 400.w,
          height: 400.h,
        )
            .animate(autoPlay: true)
            .fadeIn(duration: 1000.ms)
            .scale(
              begin: const Offset(0.5, 0.5),
              end: const Offset(1.2, 1.2),
              duration: 800.ms,
              curve: Curves.easeInOut,
            )
            .then(delay: 200.ms)
            .rotate(
              begin: 0,
              end: 1,
              duration: 600.ms,
              curve: Curves.easeOut,
            )
            .slideY(
              begin: 0,
              end: -0.2,
              duration: 500.ms,
              curve: Curves.easeIn,
            )
            .fadeOut(duration: 500.ms),
      ),
    );
  }
}
