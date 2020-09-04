import 'package:shift_tracker/Classes/job.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite_dev.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await createDB();
    return _database;
  }

  Future<Database> createDB() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(join(dbPath, 'main.db'), version: 1,
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE jobs ("
          "jobID INTEGER PRIMARY KEY,"
          "name TEXT,"
          "rateOfPay REAL,"
          "payFreq INTEGER"
          ")");
    });
  }

  newJob(Job newJob) async {
    final db = await database;
    final newID = await newJobId();
    var res = await db.rawInsert('''
      INSERT INTO jobs (
        jobID,
        name,
        rateOfPay,
        payFreq
      ) VALUES (?, ?, ?, ?)
      ''', [newID, newJob.getName(), newJob.getRateOfPay(), 1]);
  }

  Future<dynamic> getJobs() async {
    final db = await database;
    var res = await db.rawQuery('''
      SELECT * FROM jobs
      ''');

    if (res.length == 0) return null;

    return res;
  }

  Future<int> newJobId() async {
    final db = await database;
    List<Map> res = await db.rawQuery("SELECT jobID from jobs");
    if (res.isNotEmpty) {
      List<int> ids = new List<int>();
      for (Map m in res) {
        ids.add(m['jobID']);
      }

      for (int i = 0; i <= ids.length; i++) {
        if (!ids.contains(i)) return i;
      }
    }
    return 0;
  }

  Future<bool> removeJob(int jobID) async {
    final db = await database;
    var res = await db.rawQuery('''
    DELETE FROM jobs WHERE jobID = $jobID
    ''');
    print(res);
    return true;
  }

  closeDB() async {
    _database.close();
  }
}
