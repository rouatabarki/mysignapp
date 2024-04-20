// 1- we want to open a database if it exists, if not, we will create a new one + insert the record in it,database migration,
// 2- we want to query the database by word submission,
// 3- we want to close the database once the app disposes


// SOLID: DEPENDENCY INVERSION
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract interface class DatabaseClass<T>{

  Future<String>getDataBasePath();

  Future<T>createOrOpenDatabase();

  Future<String>queryOneElementFromDb({required String queryString,required String tableName});

  Future<bool>closeDb();

}
class SQFliteDb implements DatabaseClass<Database>{

   final String dbName;
   SQFliteDb({required this.dbName});


  @override
  Future<bool> closeDb() {
    // TODO: implement closeDb
    throw UnimplementedError();
  }

  /// this methode comes from [DatabaseClass]
  @override
  Future<Database> createOrOpenDatabase()async {
    final path= await getDataBasePath();

    return await openDatabase(path,
        onCreate: (database,version){
        // 1- we need to initialize the message values that will
          // trigger the animations



        },


    );
  }

  @override
  Future<String> queryOneElementFromDb({required String queryString, required String tableName}) {
    // TODO: implement queryOneElementFromDb
    throw UnimplementedError();
  }

  @override
  Future<String> getDataBasePath()async {
    var dbAbsolutePath = await getDatabasesPath();
    String directPath = join(dbAbsolutePath, dbName);
  return directPath;
  }




}



