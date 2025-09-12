class Mare {
  final String id;
  final String name;
  final String isNumber;
  final String location;
  final String? extraNumber1;
  final String? extraNumber2;
  final String? microchip;
  final String? imagePath;
  final bool isPregnant;
  final bool needsVet;
  final String? owner;
  final String? phone;
  final String? email;
  final String? comments;
  final DateTime? confirmedPregnancyDate;

  Mare({
    required this.id,
    required this.name,
    required this.isNumber,
    required this.location,
    this.extraNumber1,
    this.extraNumber2,
    this.microchip,
    this.imagePath,
    this.isPregnant = false,
    this.needsVet = false,
    this.owner,
    this.phone,
    this.email,
    this.comments,
    this.confirmedPregnancyDate,
  });

  Mare copyWith({
    String? id,
    String? name,
    String? isNumber,
    String? location,
    String? extraNumber1,
    String? extraNumber2,
    String? microchip,
    String? imagePath,
    bool? isPregnant,
    bool? needsVet,
    String? owner,
    String? phone,
    String? email,
    String? comments,
    DateTime? confirmedPregnancyDate,
  }) {
    return Mare(
      id: id ?? this.id,
      name: name ?? this.name,
      isNumber: isNumber ?? this.isNumber,
      location: location ?? this.location,
      extraNumber1: extraNumber1 ?? this.extraNumber1,
      extraNumber2: extraNumber2 ?? this.extraNumber2,
      microchip: microchip ?? this.microchip,
      imagePath: imagePath ?? this.imagePath,
      isPregnant: isPregnant ?? this.isPregnant,
      needsVet: needsVet ?? this.needsVet,
      owner: owner ?? this.owner,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      comments: comments ?? this.comments,
      confirmedPregnancyDate: confirmedPregnancyDate ?? this.confirmedPregnancyDate,
    );
  }
}
