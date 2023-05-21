class Vourcher {
    int? id;
    String? kode;
    int? nominal;
    String? createdAt;
    String? updatedAt;

    Vourcher({
         this.id,
         this.kode,
         this.nominal,
         this.createdAt,
         this.updatedAt,
    });

    factory Vourcher.fromJson(Map<String, dynamic> json) => Vourcher(
      id: json["id"],
      kode: json["kode"],
      nominal: json["nominal"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nominal": nominal,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

}