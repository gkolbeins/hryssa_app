class Mare {
  final String id;
  final String ownerId;
  final DateTime createdAt;
  final String name;
  final String? isNumber;
  final String? chipId;
  final String? currentPaddockId;
  final String? currentStallionId;
  final bool needsVet;
  final bool pregnancyConfirmed;
  final DateTime? pregnancyConfirmedAt;
  final DateTime? arrivalDate;
  final String? ownerName;
  final String? ownerPhone;
  final String? ownerEmail;
  final String? notes;
  final String? otherInfo1;
  final String? otherInfo2;
  final String? location;
  final String? imagePath;
  final String? comments;

  Mare({
    required this.id,
    required this.ownerId,
    required this.createdAt,
    required this.name,
    this.isNumber,
    this.chipId,
    this.currentPaddockId,
    this.currentStallionId,
    this.needsVet = false,
    this.pregnancyConfirmed = false,
    this.pregnancyConfirmedAt,
    this.arrivalDate,
    this.ownerName,
    this.ownerPhone,
    this.ownerEmail,
    this.notes,
    this.otherInfo1,
    this.otherInfo2,
    this.location,
    this.imagePath,
    this.comments, required String phone,
  });

  ///supabase mapping
  factory Mare.fromMap(Map<String, dynamic> map) {
    return Mare(
      id: map['id'],
      ownerId: map['owner_id'],
      createdAt: DateTime.parse(map['created_at']),
      name: map['name'],
      isNumber: map['is_number'],
      chipId: map['chip_id'],
      currentPaddockId: map['current_paddock_id'],
      currentStallionId: map['current_stallion_id'],
      needsVet: map['needs_vet'] ?? false,
      pregnancyConfirmed: map['pregnancy_confirmed'] ?? false,
      pregnancyConfirmedAt: map['pregnancy_confirmed_at'] != null
          ? DateTime.parse(map['pregnancy_confirmed_at'])
          : null,
      arrivalDate: map['arrival_date'] != null
          ? DateTime.parse(map['arrival_date'])
          : null,
      ownerName: map['owner_name'],
      ownerPhone: map['owner_phone'],
      ownerEmail: map['owner_email'],
      notes: map['notes'],
      otherInfo1: map['other_info_1'],
      otherInfo2: map['other_info_2'], phone: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'is_number': isNumber,
      'chip_id': chipId,
      'current_paddock_id': currentPaddockId,
      'current_stallion_id': currentStallionId,
      'needs_vet': needsVet,
      'pregnancy_confirmed': pregnancyConfirmed,
      'pregnancy_confirmed_at':
          pregnancyConfirmedAt?.toIso8601String(),
      'arrival_date': arrivalDate?.toIso8601String(),
      'owner_name': ownerName,
      'owner_phone': ownerPhone,
      'owner_email': ownerEmail,
      'notes': notes,
      'other_info_1': otherInfo1,
      'other_info_2': otherInfo2,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
