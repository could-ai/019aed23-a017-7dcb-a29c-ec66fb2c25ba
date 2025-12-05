import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Estado del juego simulado
  bool isMicOn = false;
  String currentWeapon = 'Pistola 9mm';
  IconData currentWeaponIcon = LucideIcons.crosshair;
  double playerX = 0;
  double playerY = 0;
  List<String> chatMessages = [
    "Sistema: Bienvenido a Guerra Palosmar",
    "Jugador1: ¿Dónde están los carros?",
    "Admin: En el centro de la ciudad",
  ];

  // Simulación de movimiento
  void _movePlayer(double dx, double dy) {
    setState(() {
      playerX += dx;
      playerY += dy;
      // Límites simples
      if (playerX > 150) playerX = 150;
      if (playerX < -150) playerX = -150;
      if (playerY > 250) playerY = 250;
      if (playerY < -250) playerY = -250;
    });
  }

  void _toggleMic() {
    setState(() {
      isMicOn = !isMicOn;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isMicOn ? 'Micrófono ACTIVADO' : 'Micrófono DESACTIVADO'),
        duration: const Duration(milliseconds: 500),
        backgroundColor: isMicOn ? Colors.green : Colors.red,
      ),
    );
  }

  void _showEmotes() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: GridView.count(
          crossAxisCount: 4,
          padding: const EdgeInsets.all(20),
          children: [
            _emoteButton('👋', 'Saludar'),
            _emoteButton('💃', 'Bailar'),
            _emoteButton('😂', 'Reír'),
            _emoteButton('😡', 'Insultar'),
            _emoteButton('🚗', 'Pedir Carro'),
            _emoteButton('🔫', 'Amenazar'),
            _emoteButton('💰', 'Dinero'),
            _emoteButton('🆘', 'Ayuda'),
          ],
        ),
      ),
    );
  }

  Widget _emoteButton(String emoji, String label) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        setState(() {
          chatMessages.add("Yo: $emoji");
        });
      },
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 30)),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }

  void _changeWeapon() {
    setState(() {
      if (currentWeapon == 'Pistola 9mm') {
        currentWeapon = 'AK-47';
        currentWeaponIcon = LucideIcons.sword; // Representación
      } else if (currentWeapon == 'AK-47') {
        currentWeapon = 'Bazooka';
        currentWeaponIcon = LucideIcons.bomb;
      } else {
        currentWeapon = 'Pistola 9mm';
        currentWeaponIcon = LucideIcons.crosshair;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Fondo del Mundo (Mapa Simulado)
          Positioned.fill(
            child: Container(
              color: const Color(0xFF3E2723), // Color tierra
              child: Stack(
                children: [
                  // Calles simuladas
                  Center(child: Container(width: 100, height: double.infinity, color: Colors.grey[800])),
                  Center(child: Container(width: double.infinity, height: 100, color: Colors.grey[800])),
                  // Edificios simulados
                  Positioned(top: 50, left: 50, child: _buildBuilding(Colors.brown)),
                  Positioned(bottom: 100, right: 50, child: _buildBuilding(Colors.blueGrey)),
                  Positioned(top: 100, right: 80, child: _buildBuilding(Colors.grey)),
                  
                  // JUGADOR (Círculo verde estilo GTA 1/2)
                  Center(
                    child: Transform.translate(
                      offset: Offset(playerX, playerY),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10)
                          ],
                        ),
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. HUD Superior (Vida, Dinero, Armas)
          Positioned(
            top: 40,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('\$ 1,000,500', 
                  style: GoogleFonts.pirataOne(color: Colors.greenAccent, fontSize: 30, shadows: [const Shadow(blurRadius: 2, color: Colors.black)])),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(LucideIcons.heart, color: Colors.red, size: 20),
                    const SizedBox(width: 5),
                    Container(width: 100, height: 10, color: Colors.grey, child: FractionallySizedBox(widthFactor: 0.8, alignment: Alignment.centerLeft, child: Container(color: Colors.red))),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(LucideIcons.shield, color: Colors.blue, size: 20),
                    const SizedBox(width: 5),
                    Container(width: 100, height: 10, color: Colors.grey, child: FractionallySizedBox(widthFactor: 0.5, alignment: Alignment.centerLeft, child: Container(color: Colors.blue))),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: _changeWeapon,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Row(
                      children: [
                        Icon(currentWeaponIcon, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(currentWeapon, style: const TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. Chat y Micrófono (Izquierda Superior)
          Positioned(
            top: 40,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  height: 100,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                  child: ListView.builder(
                    itemCount: chatMessages.length,
                    itemBuilder: (context, index) => Text(chatMessages[index], style: const TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    FloatingActionButton.small(
                      heroTag: 'mic',
                      backgroundColor: isMicOn ? Colors.green : Colors.grey,
                      onPressed: _toggleMic,
                      child: Icon(isMicOn ? LucideIcons.mic : LucideIcons.micOff),
                    ),
                    const SizedBox(width: 10),
                    FloatingActionButton.small(
                      heroTag: 'emote',
                      backgroundColor: Colors.orange,
                      onPressed: _showEmotes,
                      child: const Icon(LucideIcons.smile),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 4. Controles (Joystick y Botones de Acción)
          Positioned(
            bottom: 40,
            left: 40,
            child: _buildJoystick(),
          ),

          Positioned(
            bottom: 40,
            right: 40,
            child: Row(
              children: [
                _buildActionButton(Icons.directions_car, Colors.blue, () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Buscando vehículo cercano...")));
                }),
                const SizedBox(width: 20),
                _buildActionButton(LucideIcons.crosshair, Colors.red, () {
                  // Efecto de disparo
                  setState(() {
                     // Animación simple o sonido
                  });
                }),
                const SizedBox(width: 20),
                _buildActionButton(Icons.run_circle, Colors.green, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuilding(Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: Colors.black, width: 2),
        boxShadow: const [BoxShadow(offset: Offset(5, 5), color: Colors.black45)],
      ),
      child: const Center(child: Text("EDIFICIO", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildJoystick() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.arrow_drop_up, color: Colors.white), onPressed: () => _movePlayer(0, -20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(icon: const Icon(Icons.arrow_left, color: Colors.white), onPressed: () => _movePlayer(-20, 0)),
              const SizedBox(width: 10),
              IconButton(icon: const Icon(Icons.arrow_right, color: Colors.white), onPressed: () => _movePlayer(20, 0)),
            ],
          ),
          IconButton(icon: const Icon(Icons.arrow_drop_down, color: Colors.white), onPressed: () => _movePlayer(0, 20)),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, spreadRadius: 2),
          ],
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
