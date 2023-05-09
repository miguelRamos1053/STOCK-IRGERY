import 'package:flutter/material.dart';
import 'package:hola_mundo/src/views/crearProducto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late final boton;

  setUpAll(() {
    boton = find.byKey(const Key('btnEnviar'));
  });
  group('ValidarCodigo > ', () {
    late final campoTexto;
    setUpAll(() {
      campoTexto = find.byKey(const Key('codigo'));
    });
    testWidgets('CodigoRequerido', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El código es requerido');

      expect(texto, findsOneWidget);
    });
    testWidgets('LongitudCodigo', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, 'C');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El código debe tener mínimo 2 caracteres');

      expect(texto, findsOneWidget);
    });
    testWidgets('CodigoValido', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, 'C315');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El código es requerido');
      final texto2 = find.text('El código debe tener mínimo 2 caracteres');
      expect(texto, findsNothing);
      expect(texto2, findsNothing);
    });
  });

  group('ValidarNombre > ', () {
    late final campoTexto;
    setUpAll(() {
      campoTexto = find.byKey(const Key('CampoNombre'));
    });
    testWidgets('NombreVacio', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El nombre es requerido');

      expect(texto, findsOneWidget);
    });

    testWidgets('NombreNoVacio', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, 'Martillo');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El nombre es requerido');

      expect(texto, findsNothing);
    });
  });

  group('ValidarCantidad > ', () {
    late final campoTexto;

    setUpAll(() {
      campoTexto = find.byKey(const Key('CampoCantidad'));
    });
    testWidgets('CantidadVacia', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('La cantidad es requerida');

      expect(texto, findsOneWidget);
    });

    testWidgets('CantidadNegativa', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '-1');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('La cantidad no puede ser negativa');

      expect(texto, findsOneWidget);
    });
    testWidgets('CantidadValida', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '1');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('La cantidad no puede ser negativa');
      final texto2 = find.text('La cantidad es requerida');
      expect(texto, findsNothing);
      expect(texto2, findsNothing);
    });
  });

  group('ValidarPrecio > ', () {
    late final campoTexto;

    setUpAll(() {
      campoTexto = find.byKey(const Key('CampoPrecio'));
    });
    testWidgets('PrecioMayorACero', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '-1000');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El precio debe ser mayor a 0');

      expect(texto, findsOneWidget);
    });
    testWidgets('PrecioVacio', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El precio es requerido');

      expect(texto, findsOneWidget);
    });

    testWidgets('PrecioValido', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CrearProducto()));
      await widgetTester.enterText(campoTexto, '1000');
      await widgetTester.ensureVisible(boton);
      await widgetTester.tap(boton);

      await widgetTester.pumpAndSettle();
      final texto = find.text('El precio es requerido');
      final texto2 = find.text('El precio debe ser mayor a 0');

      expect(texto, findsNothing);
      expect(texto2, findsNothing);
    });
  });
}
