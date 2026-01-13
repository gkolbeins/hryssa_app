class Stallion {
  final String id;
  final String name;
  final String? isNumber;
  final String? chipId;
  final String ownerId;
  final DateTime createdAt;

  Stallion({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.createdAt,
    this.isNumber,
    this.chipId,
  });

  ///gert með það í huga að þetta passi við Supabes gagnagrunninn
  factory Stallion.fromMap(Map<String, dynamic> map) {
    return Stallion(
      id: map['id'] as String,
      name: map['name'] as String,
      ownerId: map['owner_id'] as String,
      isNumber: map['is_number'] as String?,
      chipId: map['chip_id'] as String?,
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'owner_id': ownerId,
      'is_number': isNumber,
      'chip_id': chipId,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
