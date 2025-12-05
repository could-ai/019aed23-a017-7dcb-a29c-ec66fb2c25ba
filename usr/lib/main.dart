import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/menu_screen.dart';
import 'screens/game_screen.dart';

void main() {
  runApp(const GuerraPalosmarApp());
}

class GuerraPalosmarApp extends StatelessWidget {
  const GuerraPalosmarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guerra Palosmar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF2E7D32), // Verde estilo Grove Street
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MenuScreen(),
        '/game': (context) => const GameScreen(),
      },
    );
  }
}
