class Items {
  int id;
  String nama;
  int harga;
  String tipe;
  String gambar;

  Items({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
  });

  factory Items.fromJson(Map<String, dynamic> json) => Items(
      id: json["id"],
      nama: json["nama"],
      harga: json["harga"],
      tipe: json["tipe"],
      gambar: json["gambar"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "harga": harga,
        "tipe": tipe,
        "gambar": id,
      };
}
