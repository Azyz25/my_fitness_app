// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';
import 'main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const TechneApp(),
    ),
  );
}

class TechneApp extends StatefulWidget {
  const TechneApp({super.key});

  @override
  State<TechneApp> createState() => _TechneAppState();
}

class _TechneAppState extends State<TechneApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: 'Techne Fitness',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          locale: const Locale('ar', 'SA'),
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: child!,
            );
          },
          home: _showSplash
              ? SplashScreen(
                  onDone: () => setState(() => _showSplash = false),
                )
              : const MainShell(),
        );
      },
    );
  }
}
