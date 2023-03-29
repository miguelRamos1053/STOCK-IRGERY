
import 'dart:convert';

FlujoInventarioModel flujoInventarioFromJson(String str) => FlujoInventarioModel.fromJson(json.decode(str));

String flujoInventarioToJson(FlujoInventarioModel data) => json.encode(data.toJson());

class FlujoInventarioModel {
    FlujoInventarioModel({
        required this.id,
        required this.fecha,
        this.tipo,
        this.cantidad=0,
        required this.idProducto,
    });

    int id;
    String fecha;
    String? tipo;
    int cantidad;
    int idProducto;

    factory FlujoInventarioModel.fromJson(Map<String, dynamic> json) => FlujoInventarioModel(
        id: json["id"],
        fecha: json["fecha"],
        tipo: json["tipo"],
        cantidad: json["cantidad"],
        idProducto: json["idProducto"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fecha": fecha,
        "tipo": tipo,
        "cantidad": cantidad,
        "idProducto": idProducto,
    };
}
