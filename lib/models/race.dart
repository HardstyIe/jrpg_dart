import 'dart:math';

class Race {
  final String name;
  final int attackBonus;
  final int magicBonus;
  final int healthBonus;

  Race(this.name, this.attackBonus, this.magicBonus, this.healthBonus);
}

List<Race> availableRaces = [
  Race('Humain', 0, 0, 0),
  Race('Orc', 5, 0, 10),
  Race('Elfe', 0, 10, 0),
];

Race getRandomRace() {
  return availableRaces[Random().nextInt(availableRaces.length)];
}

Race getRaceByName(String raceName) {
  return availableRaces.firstWhere((race) => race.name == raceName);
}
