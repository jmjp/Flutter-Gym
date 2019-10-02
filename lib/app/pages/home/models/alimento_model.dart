import 'dart:convert';

List<Alimentos> alimentosFromJson(String str) => List<Alimentos>.from(json.decode(str).map((x) => Alimentos.fromJson(x)));

String alimentosToJson(List<Alimentos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alimentos {
    String nome;
    int calorias;
    int idAlimento;
    int idGrupo;
    Grupo grupo;

    Alimentos({
        this.nome,
        this.calorias,
        this.idAlimento,
        this.idGrupo,
        this.grupo,
    });

    factory Alimentos.fromJson(Map<String, dynamic> json) => Alimentos(
        nome: json["nome"],
        calorias: json["calorias"],
        idAlimento: json["id_alimento"],
        idGrupo: json["id_grupo"],
        grupo: Grupo.fromJson(json["grupo"]),
    );

    Map<String, dynamic> toJson() => {
        "nome": nome,
        "calorias": calorias,
        "id_alimento": idAlimento,
        "id_grupo": idGrupo,
        "grupo": grupo.toJson(),
    };
}

class Grupo {
    String nome;
    int idGrupo;

    Grupo({
        this.nome,
        this.idGrupo,
    });

    factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        nome: json["nome"],
        idGrupo: json["id_grupo"],
    );

    Map<String, dynamic> toJson() => {
        "nome": nome,
        "id_grupo": idGrupo,
    };
}
