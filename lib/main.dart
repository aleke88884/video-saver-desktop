import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:video_desktop_saver/core/constants/app_constants.dart';
import 'package:video_desktop_saver/core/routing/app_router.dart';
import 'package:video_desktop_saver/features/keyboard/data/typing_result.dart';
import 'package:video_desktop_saver/features/keyboard/domain/keyboard_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();

  // WindowOptions windowOptions = const WindowOptions(
  //   center: true,
  //   backgroundColor: Colors.transparent,
  //   skipTaskbar: false,
  //   title: 'Slyth',
  //   minimumSize: Size(1440, 1024),
  // );
  // windowManager.waitUntilReadyToShow(windowOptions, () async {
  //   await windowManager.setFullScreen(false);
  //   await windowManager.setAlwaysOnTop(true);

  //   await windowManager.setResizable(true);
  //   await windowManager.show();
  //   await windowManager.focus();
  // });
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);

  Hive.registerAdapter(TypingResultAdapter());

  await Hive.openBox<TypingResult>(AppConstants.resultBox);

  await Supabase.initialize(
    url: 'https://dvphnvjncfnmpbbcwscf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2cGhudmpuY2ZubXBiYmN3c2NmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDUyOTk0NTMsImV4cCI6MjA2MDg3NTQ1M30.-BPB2ZD9dvIZic6AP1dlVdWzMhiJAV25PM50ni6h2QI',
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => KeyboardState(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        title: 'Slyth',
        theme: AppConstants.appTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
