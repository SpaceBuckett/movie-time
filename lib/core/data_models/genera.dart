class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  // Genre copyWith({
  //   int? id,
  //   String? name,
  // }) {
  //   return Genre(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //   );
  // }

  factory Genre.fromMap(Map<String, dynamic> map) {
    return Genre(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
