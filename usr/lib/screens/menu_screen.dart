import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF000000),
              Color(0xFF1B5E20), // Gradiente verde oscuro
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título del juego estilo GTA
                Text(
                  'GUERRA',
                  style: GoogleFonts.pirataOne(
                    fontSize: 60,
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                ),
                Text(
                  'PALOSMAR',
                  style: GoogleFonts.pirataOne(
                    fontSize: 80,
                    color: const Color(0xFF4CAF50), // Verde brillante
                    shadows: [
                      const Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(5.0, 5.0),
                      ),
                      const Shadow(
                        blurRadius: 2.0,
                        color: Colors.white,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                
                // Botones del menú
                _buildMenuButton(context, 'JUGAR EN LÍNEA', () {
                  Navigator.pushNamed(context, '/game');
                }),
                _buildMenuButton(context, 'OPCIONES', () {}),
                _buildMenuButton(context, 'SALIR', () {}),
                
                const Spacer(),
                const Text(
                  'v1.0.0 - Servidores: ONLINE',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black.withOpacity(0.6),
            foregroundColor: Colors.white,
            side: const BorderSide(color: Colors.white54, width: 2),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
