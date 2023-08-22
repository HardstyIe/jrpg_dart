import 'dart:math';

class Race {
  final String name;
  final int attackBonus;
  final int magicBonus;
  final int healthBonus;

  Race(this.name, this.attackBonus, this.magicBonus, this.healthBonus);
}

List<Race> availableRaces = [
// Humains : polyvalents, peuvent utiliser une variété d'équipements
  Race('Human', 0, 0, 0),
  // Orcs : forts et robustes, préfèrent les armes lourdes
  Race('Orc', 5, 0, 10),
  // Elfes : agiles et magiques, préfèrent les armes à distance et la magie
  Race('Elf', 0, 10, 0),
  // Nains : forts et résistants, préfèrent les armes lourdes et les armures
  Race('Dwarf', 5, -5, 15),

  // Gobelins : agiles mais faibles, préfèrent les armes légères et rapides
  Race('Goblin', -5, 5, -5),

  // Sorciers : maîtres de la magie, préfèrent les objets magiques
  Race('Wizard', -5, 15, -5),

  // Guerriers : forts et courageux, préfèrent les armes et armures lourdes
  Race('Warrior', 10, -5, 10),

  // Voleurs : agiles et rusés, préfèrent les armes légères et rapides
  Race('Thief', 0, 0, 0),
];

Race getRandomRace() {
  return availableRaces[Random().nextInt(availableRaces.length)];
}

Race getRaceByName(String raceName) {
  return availableRaces.firstWhere((race) => race.name == raceName);
}
