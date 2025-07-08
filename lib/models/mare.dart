class Mare {
  final String id;
  final String name;
  final String isNumber;
  final String location;
  final bool needsVet;
  final bool isPregnant;
  final String? extraNumber1;
  final String? extraNumber2;
  final String? microchip;
  final String? imagePath;

  Mare({
    required this.id,
    required this.name,
    required this.isNumber,
    required this.location,
    this.needsVet = false,
    this.isPregnant = false,
    this.extraNumber1,
    this.extraNumber2,
    this.microchip,
    this.imagePath,
  });

  Mare copyWith({
    String? id,
    String? name,
    String? isNumber,
    String? location,
    bool? needsVet,
    bool? isPregnant,
    String? extraNumber1,
    String? extraNumber2,
    String? microchip,
    String? imagePath,
  }) {
    return Mare(
      id: id ?? this.id,
      name: name ?? this.name,
      isNumber: isNumber ?? this.isNumber,
      location: location ?? this.location,
      needsVet: needsVet ?? this.needsVet,
      isPregnant: isPregnant ?? this.isPregnant,
      extraNumber1: extraNumber1 ?? this.extraNumber1,
      extraNumber2: extraNumber2 ?? this.extraNumber2,
      microchip: microchip ?? this.microchip,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
