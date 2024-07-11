class Animal {
  final int id;
  String jenis_hewan;
  String nama_hewan;
  String foto;
  String keterangan;
  String status;
  int owner_id;
  int adopter_id;

  Animal({
    required this.id,
    required this.jenis_hewan,
    required this.nama_hewan,
    required this.foto,
    required this.keterangan,
    required this.status,
    required this.owner_id,
    required this.adopter_id,
  });

  factory Animal.fromJson(Map<String, dynamic> json) {
    return Animal(
        id: json["id"] as int,
        jenis_hewan: json["jenis_hewan"] as String,
        nama_hewan: json["nama_hewan"] as String,
        foto: json["foto"] as String,
        keterangan: json["keterangan"] as String,
        status: json["status"] as String,
        owner_id: json["owner_id"] as int,
        adopter_id: json["adopter_id"] as int);
  }
}
