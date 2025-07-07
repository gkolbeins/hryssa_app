class Mare {
  final String id;
  final String name;
  final String isNumber;
  final String location;
  final bool needsVet;

  Mare({
    required this.id,
    required this.name,
    required this.isNumber,
    required this.location,
    this.needsVet = false,
  });
}
