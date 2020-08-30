import 'package:shift_tracker/Classes/job.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite_dev.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return database;

    var dbPath = await getDatabasesPath();
    _database = await openDatabase(
      dbPath, 
      version: 1,
      onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE jobs (
            jobID INTEGER PRIMARY KEY,
            name TEXT,
            rateOfPay REAL,
            payFreq INTEGER
          )''');
    });
    return _database;
  }

  newJob(Job newJob) async {
    print("HERE");
    final db = await database;

    var res = await db.rawInsert('''
      INSERT INTO jobs (
        jobID,
        name,
        rateOfPay,
        payFreq
      ) VALUES (?, ?, ?, ?)
      ''', [0, newJob.getName(), newJob.getRateOfPay(), 1]);

    print("HERE1");

    print(getJobs());
  }

  Future<dynamic> getJobs() async {
    final db = await database;
    var res = await db.rawQuery('''
      SELECT * FROM jobs
      ''');

    print(res);

    if (res.length == 0) return null;

    return res;
  }

  closeDB() async {
    _database.close();
  }
}
