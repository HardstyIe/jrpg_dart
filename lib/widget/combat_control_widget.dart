import 'package:flutter/material.dart';

class CombatControlsWidget extends StatelessWidget {
  final Function performTurn;
  final Function resetGame;
  final Function resetOpponentHealth; // Ajoutez cette ligne

  CombatControlsWidget({
    required this.performTurn,
    required this.resetGame,
    required this.resetOpponentHealth, // Ajoutez cette ligne
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => performTurn(),
          child: const Text('Prochain tour'),
        ),
        ElevatedButton(
          onPressed: () => resetGame(),
          child: const Text('Réinitialiser'),
        ),
        ElevatedButton(
          onPressed: () => resetOpponentHealth(), // Ajoutez cette ligne
          child: const Text(
              'Réinitialiser les HP de l\'adversaire'), // Ajoutez cette ligne
        ),
      ],
    );
  }
}
