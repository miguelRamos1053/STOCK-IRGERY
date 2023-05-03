import 'dart:convert';

ProductoModel productoFromJson(String str) =>
    ProductoModel.fromJson(json.decode(str));

String productoToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  ProductoModel({
    required this.id,
    required this.codigo,
    required this.nombre,
    this.detalles,
    this.cantidad = 0,
    required this.creadoPor,
  });

  int id;
  String codigo;
  String nombre;
  String? detalles;
  int cantidad;
  int creadoPor;

  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
        id: json["id"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        detalles: json["detalles"],
        cantidad: json["cantidad"],
        creadoPor: json["creadoPor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "detalles": detalles,
        "cantidad": cantidad,
        "creadoPor": creadoPor,
      };
}
