

import 'dart:convert';

UsuarioModel usuarioFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
    UsuarioModel({
        required this.id,
        required this.nombre,
        required this.correo,
        required this.contrasenia,
    });

    int id;
    String nombre;
    String correo;
    String contrasenia;

    factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        correo: json["correo"],
        contrasenia: json["contrasenia"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "correo": correo,
        "contrasenia": contrasenia,
    };
}
