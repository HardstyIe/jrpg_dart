class Equipement {
  final String name;
  final int attackBonus;
  final int magicBonus;
  final int healthBonus;

  Equipement(this.name, this.attackBonus, this.healthBonus, this.magicBonus);
}

class EquipmentCategory {
  final String name;
  final List<Equipement> equipments;

  EquipmentCategory(this.name, this.equipments);
}

class EquipmentSet {
  final String name;
  final EquipmentCategory
      armorCategory; // Catégorie d'armure (légère, moyenne, lourde)
  final List<Equipement> weapons; // Liste des armes dans cet ensemble

  EquipmentSet(this.name, this.armorCategory, this.weapons);
}

// Vos catégories d'armures
final lightArmorCategory = EquipmentCategory('Armure légère', [
  Equipement('Armure de cuir', 5, 10, 0),
  Equipement('Robe de mage', 0, 5, 5),
]);

final mediumArmorCategory = EquipmentCategory('Armure moyenne', [
  Equipement('Cotte de mailles', 0, 20, 0),
]);

final heavyArmorCategory = EquipmentCategory('Armure lourde', [
  Equipement('Armure de plaques', 0, 30, 0),
]);

// Vos armes disponibles
List<Equipement> availableWeapons = [
  Equipement('Bouclier', 0, 10, 0),
  Equipement('Epée', 10, 0, 0),
  Equipement('Baton', 0, 0, 10),
  Equipement('Dague', 5, 0, 0),
  Equipement('Hache', 15, -5, 0),
  Equipement('Arc', 8, 0, 0),
  Equipement('Lance', 10, 0, 0),
];

final humanEquipmentSet =
    EquipmentSet('Equipement Humain', lightArmorCategory, [
  availableWeapons[1], // Epée
  availableWeapons[3], // Dague
]);

final orcEquipmentSet = EquipmentSet('Equipement Orc', heavyArmorCategory, [
  availableWeapons[4], // Hache
  availableWeapons[6], // Lance
]);

final elfEquipmentSet = EquipmentSet('Equipement Elfe', lightArmorCategory, [
  availableWeapons[2], // Baton
  availableWeapons[5], // Arc
]);

final dwarfEquipmentSet = EquipmentSet('Equipement Nain', heavyArmorCategory, [
  availableWeapons[0], // Bouclier
  availableWeapons[4], // Hache
]);

final goblinEquipmentSet =
    EquipmentSet('Equipement Gobelin', lightArmorCategory, [
  availableWeapons[3], // Dague
  availableWeapons[5], // Arc
]);

final wizardEquipmentSet =
    EquipmentSet('Equipement Sorcier', lightArmorCategory, [
  availableWeapons[2], // Baton
]);

final warriorEquipmentSet =
    EquipmentSet('Equipement Guerrier', mediumArmorCategory, [
  availableWeapons[1], // Epée
  availableWeapons[6], // Lance
]);

final thiefEquipmentSet =
    EquipmentSet('Equipement Voleur', lightArmorCategory, [
  availableWeapons[3], // Dague
]);
// Vos ensembles d'équipements disponibles

List<EquipmentSet> availableEquipmentSets = [
  humanEquipmentSet,
  orcEquipmentSet,
  elfEquipmentSet,
  dwarfEquipmentSet,
  goblinEquipmentSet,
  wizardEquipmentSet,
  warriorEquipmentSet,
  thiefEquipmentSet,
];
