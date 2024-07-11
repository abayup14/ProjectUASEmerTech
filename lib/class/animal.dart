class Animal {
  final int id;
  String jenis_hewan;
  String nama_hewan;
  String foto;
  String keterangan;
  String status;
  int owner_id;
  String nama_owner;
  int? adopter_id;
  String? nama_adopter;

  Animal({
    required this.id,
    required this.jenis_hewan,
    required this.nama_hewan,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.owner_id,
    required this.nama_owner,
    this.adopter_id,
    this.nama_adopter,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
        id: json["id_hewan"] as int,
        jenis_hewan: json["jenis_hewan"] as String,
        nama_hewan: json["nama_hewan"] as String,
        foto: json["foto"] as String,
        keterangan: json["keterangan"] as String,
        status: json["status"] as String,
        owner_id: json["owner_id"] as int,
        nama_owner: json["nama_owner"] as String,
        adopter_id: json["adopter_id"] as int? ?? 0,
        nama_adopter: json["nama_adopter"] as String? ?? "");
  }

  factory Animal.fromJson2(Map<String, dynamic> json) {
    return Animal(
        id: json["id"] as int,
        jenis_hewan: json["jenis_hewan"] as String,
        nama_hewan: json["nama_hewan"] as String,
        foto: json["foto"] as String,
        keterangan: json["keterangan"] as String,
        status: json["status"] as String? ?? "",
        owner_id: json["owner_id"] as int? ?? 0,
        nama_owner: json["nama_owner"] as String? ?? "",
        adopter_id: json["adopter_id"] as int? ?? 0,
        nama_adopter: json["nama_adopter"] as String? ?? "");
  }
}

class Adopt {
  final int id;
  String jenis_hewan;
  String nama_hewan;
  String foto;
  String keterangan;
  String status;
  int owner_id;
  int adopter_id;
  String status2;

  Adopt({
    required this.id,
    required this.jenis_hewan,
    required this.nama_hewan,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.owner_id,
    required this.adopter_id,
    required this.status2,
  });

  factory Adopt.fromJson(Map<String, dynamic> json) {
    return Adopt(
        id: json["id"] as int,
        jenis_hewan: json["jenis_hewan"] as String,
        nama_hewan: json["nama_hewan"] as String,
        foto: json["foto"] as String,
        keterangan: json["keterangan"] as String,
        status: json["status"] as String,
        owner_id: json["owner_id"] as int,
        adopter_id: json["adopter_id"] as int,
        status2: json["status2"] as String);
  }
}

class Offers {
  final int id;
  String jenis_hewan;
  String nama_hewan;
  String foto;
  String keterangan;
  String status;
  int propose_count;

  Offers({
    required this.id,
    required this.jenis_hewan,
    required this.nama_hewan,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.propose_count,
  });

  factory Offers.fromJson(Map<String, dynamic> json) {
    return Offers(
        id: json["id"] as int,
        jenis_hewan: json["jenis_hewan"] as String,
        nama_hewan: json["nama_hewan"] as String,
        foto: json["foto"] as String,
        keterangan: json["keterangan"] as String,
        status: json["status"] as String,
        propose_count: json["propose_count"] as int);
  }
}

class Decisions {
  final int id_animals;
  final int id_adopters;
  String description;
  String fullname;

  Decisions({
    required this.id_animals,
    required this.id_adopters,
    required this.description,
    required this.fullname
  });

  factory Decisions.fromJson(Map<String, dynamic> json) {
    return Decisions(
        id_animals: json["animals_id"] as int,
        id_adopters: json["users_id"] as int,
        description: json["description"] as String,
        fullname: json["fullname"] as String);
  }
}
