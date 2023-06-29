import 'package:mysql1/mysql1.dart';

class DatabaseHelper {
  late MySqlConnection _connection;

  static DatabaseHelper? _instance;

  DatabaseHelper._privateConstructor();

  static DatabaseHelper get instance {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<void> openConnection() async {
    final settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: '123456',
      db: 'community',
    );
    _connection = await MySqlConnection.connect(settings);
  }

  Future<void> closeConnection() async {
    await _connection.close();
  }

  Future<List<Map<String, dynamic>>> getApplicationList() async {
    final results = await _connection.query('SELECT * FROM housemanagement');
    return results.map((result) => result.fields).toList();
  }

  Future<int> insertApplication(
      String owner,
      String community,
      String building,
      String unit,
      String house,
      ) async {
    final result = await _connection.query(
      'INSERT INTO application (owner, community, building, unit, house, examine) '
          'VALUES (?, ?, ?, ?, ?, 0)',
      [owner, community, building, unit, house],
    );

    // 获取插入的自增主键值
    return result.insertId!;
  }


  Future<void> updateApplicationStatus(int id, String status) async {
    await _connection.query(
      'UPDATE applications SET examine = ? WHERE id = ?',
      [status, id],
    );
  }


  Future<List<Map<String, dynamic>>> getAllData(String table) async {
    final results = await _connection.query('SELECT * FROM $table');
    return results.map((result) => result.fields).toList();
  }
}
