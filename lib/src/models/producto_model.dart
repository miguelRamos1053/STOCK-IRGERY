import 'dart:convert';

ProductoModel productoFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    required this.id,
    required this.codigo,
    required this.nombre,
    required this.precio,
    this.detalles,
    this.cantidad = 0,
    this.foto = "",
    required this.creadoPor,
  });

  int? id;
  String codigo;
  String nombre;
  int precio;
  String? detalles;
  int cantidad;
  String foto;
  int creadoPor;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        precio: json["precio"],
        detalles: json["detalles"],
        cantidad: json["cantidad"],
        foto: json["foto"],
        creadoPor: json["creadoPor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "precio": precio,
        "detalles": detalles,
        "cantidad": cantidad,
        "foto": foto,
        "creadoPor": creadoPor,
      };
}
