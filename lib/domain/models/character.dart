class Character {
  final int? id;
  final String? name;
  final String? status;
  final String? specie;
  final String? type;
  final Gender? gender;
  final String? origin;
  final String? location;
  final String? image;
  final String? episodes;
  final String? url;
  final String? created;
  final int? page;

  Character(
      {this.id,
      this.name,
      this.status,
      this.specie,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episodes,
      this.url,
      this.created,
      this.page});
}

enum Gender { male, female, unknown, all }

enum Status { alive, dead, unknown, all }
