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
}
