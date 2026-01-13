class Paddock {
  final String id;
  final String name;
  final String? location;
  final String ownerId;
  final String? stallionId;

  Paddock({
    required this.id,
    required this.name,
    required this.ownerId,
    this.location,
    this.stallionId,
  });

  factory Paddock.fromMap(Map<String, dynamic> map) {
    return Paddock(
      id: map['id'] as String,
      name: map['name'] as String,
      ownerId: map['owner_id'] as String,
      location: map['location'] as String?,
      stallionId: map['stallion_id'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'owner_id': ownerId,
      'location': location,
      'stallion_id': stallionId,
    };
  }
}
