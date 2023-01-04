import 'package:movil_ganaseguros/login/models/datos_persona_model.dart';
import 'package:movil_ganaseguros/utils/models/dominio_model.dart';
import 'package:movil_ganaseguros/polizas/models/historial_busqueda_poliza_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {

  static final DBProvider instance = DBProvider._init();

  static Database? _database;

  DBProvider._init();



  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('Ganaseguros.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE HistorialBusquedaPoliza(
    historialBusquedaPolizaId INTEGER PRIMARY KEY AUTOINCREMENT, 
    nroDocumento TEXT, 
    ciudadExpedidoId  INTEGER,
    complemento TEXT, 
    nombreAsegurado TEXT, 
    nombreTomador TEXT, 
    fechaNacimiento TEXT)
    ''');
    await db.execute('''
     CREATE TABLE DatosPersona(
    personaId INTEGER PRIMARY KEY, 
    generoId INTEGER,  
    nombres TEXT, 
    apellidoPaterno TEXT, 
    apellidoMaterno TEXT, 
    apellidoEsposo TEXT,
    numeroDocumento TEXT, 
    complemento TEXT,
    ciudadExpedidoId INTEGER,
    numeroCelular TEXT,
    correoElectronico TEXT,
    fechaNacimiento TEXT
    )
    ''');



  }

  // QUERYS PARA HISTORIAL DE BUSQUEDAS
  Future<void> nuevoHistorialBusquedaPoliza(HistorialBusquedaPolizaModel item) async {
    print("REGISTRANDO NUEVO HISOTRIAL DE BUSQUEDA==============================");
    final db = await instance.database;
    await db.transaction((txn) async {
      await txn.insert("HistorialBusquedaPoliza", item.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }

  Future<List<HistorialBusquedaPolizaModel>> obtenerTodosHistorialBusquedaPoliza() async {
    print("OBTENIENDO TODOS HISTORIAL DE BUSQUEDA  ================================");
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db.query("HistorialBusquedaPoliza");
    List<HistorialBusquedaPolizaModel> list = res.isNotEmpty
        ? res.map((e) => HistorialBusquedaPolizaModel.fromMap(e)).toList()
        : [];
    return list;

  }
  Future<HistorialBusquedaPolizaModel?> obtenerHistorialBusquedaPolizaPorNroDocumento(String pNroDocumento) async {
    print("OBTENIENDO HISTORIAL BUSQUEDA POLIZA POR NRO DE CARNET DE SQLITE ==============================");
    final db = await instance.database;
      final res = await db.query("HistorialBusquedaPoliza",where: 'nroDocumento=?',whereArgs: [pNroDocumento]);
      return res.isNotEmpty? HistorialBusquedaPolizaModel.fromMap(res.first):null ;

  }
   Future<int?> eliminarHistorialBusquedaPoliza(int pHistorialBusquedaPolizaId) async {
    print("ELIMINANDO HISTORIAL DE BUSQUEDA =================================");
    final db = await instance.database;
    return  await db.delete("HistorialBusquedaPoliza", where: 'historialBusquedaPolizaId=?', whereArgs: [pHistorialBusquedaPolizaId]);
  }
   // =============================================

// QUERYS PARA ALMACENAR DATSO PERSONAS
  Future<void> nuevoPersona(DatosPersonaModel datosPersonaModel) async {
    print("REGISTRANDO NUEVO DATOS PERSONA==============================");
    final db = await instance.database;
    await db.transaction((txn) async {
      await txn.insert("DatosPersona", datosPersonaModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    });
  }
  Future<DatosPersonaModel> obtenerDatosPersona() async {
    print("OBTENIENDO TODOS DATOS PERSONA  ================================");
    final db = await instance.database;
    final List<Map<String, dynamic>> res = await db.query("DatosPersona");
    if(res.isEmpty){
      return new DatosPersonaModel();
    }else{
      List<DatosPersonaModel> list = res.isNotEmpty
          ? res.map((e) => DatosPersonaModel.fromMap(e)).toList()
          : [];
      return list.first; // siempre habra en BD un solo registro
    }
  }
  Future<int>eliminarDatosPersonaTodos () async{
    final db = await instance.database;
    final res = await db.rawDelete('DELETE FROM DatosPersona');
    return res;
  }
// ========================

// Dominios
  /*Future<void> nuevoVariosDominios(List<DominioModel> lstDominioModel) async {
    print("REGISTRANDO NUEVO DOMINIO==============================");
    final db = await instance.database;
    await db.transaction((txn) async {
      //await txn.insert("DatosPersona", datosPersonaModel.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      await txn.rawInsert('INSERT INTO Dominios(dominioId,dominio,descripcion,abreviatura) VALUES(?, ?, ?,?)', lstDominioModel);
    });
  }
  Future<List<DominioModel>> obtenerDominiosPorNroDominio(String pDominio) async {
    print("OBTENIENDO DOMINIOS X "+pDominio+" ==============================");
    final db = await instance.database;
    final res = await db.query("Dominios",where: 'dominio=?',whereArgs: [pDominio]);

      List<DominioModel> list = res.isNotEmpty
          ? res.map((e) => DominioModel.fromMap(e)).toList()
          : [];
    return list;

  }
  Future<int>eliminarDominios () async{
    final db = await instance.database;
    final res = await db.rawDelete('DELETE FROM Dominios');
    return res;
  }*/
// =====
}
