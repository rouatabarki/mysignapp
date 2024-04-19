


import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';



class data {



  Future<void> initTexts() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'mySignApp.db'),
      onCreate: (db, version) {
        db.execute(
          'CREATE TABLE Animations(Path STRING PRIMARY KEY)',
        );
        db.execute(
          'CREATE TABLE Texts(Content STRING PRIMARY KEY)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      version: 2,

    );


    Future<void> insertAnimation(Animation animation) async {
      final db = await database;

      await db.insert(
        'Animations',
        animation.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }


    Future ShowAnimations() async {
      final db = await database;
      // final List<Map<String, Object?>> ListeMapAnim = await db.query('Animation');

      List<Map<String, Object?>> ListeMapAnim = await db.query(
        'Animations',

      );

      return ListeMapAnim;
      //   [
      //   for (final {
      //   'Path': Path as String,
      //   } in ListeMapAnim)
      //     Animation(Path: Path),
      // ];

    }

    //
    Future<void> insertText(Texte texte) async {
      final db = await database;
      await db.insert(
        'Texts',
        texte.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,

      );
    }


    ShowText1() async {
      final db = await database;
      List<Map<String, Object?>> Data1 = await db.rawQuery(
        'SELECT * FROM Texts WHERE  Content = ?',
        ['Au revoir'],

      );

      return Data1;
    }
    ShowText2() async {
      final db = await database;
      List<Map<String, Object?>> Data2 = await db.rawQuery(
        'SELECT * FROM Texts WHERE  Content = ?',
        ['nom'],

      );

      return Data2;
    }


    ShowText3() async {
      final db = await database;
      List<Map<String, Object?>> Data3 = await db.rawQuery(
        'SELECT * FROM Texts WHERE  Content = ?',
        ['prenom'],

      );

      return Data3;
    }


    ShowText4() async {
      final db = await database;
      List<Map<String, Object?>> Data4 = await db.rawQuery(
        'SELECT * FROM Texts WHERE  Content = ?',
        ['Ca va ?'],

      );

      return Data4;
    }


    var Text1 = Texte(Content: 'Au revoir');
    var Text2 = Texte(Content: 'nom');
    var Text3 = Texte(Content: 'Prenom');
    var Text4 = Texte(Content: 'Ca va ?');


    await insertText(Text4);
    print("les données sont :");
    print(await ShowText4());


    var PauseMode = Animation

      (
      Path: 'lib/assets/AuRevoir1.glb',

    );

    var nom = Animation(
      Path: 'lib/assets/lenom.glb',
    );
    var prenom = Animation(
      Path: 'lib/assets/leprenom.glb',
    );
    var cv = Animation(
      Path: 'lib/assets/CaVa.glb',
    );
    await insertAnimation(cv);
    print("les données sont :");
    print(await ShowAnimations());
  }

}
class Animation {
  final String Path;

  Animation({ required this.Path });

  Map<String, Object?> toMap() {
    return {
      'Path': Path,
    };


  }
  @override
  String toString() {
    return 'Animations{Path: $Path} ';
  }

}



class Texte {

  final String Content;

  Texte({required this.Content});

  Map<String, Object?> toMap() {
    return {
      'Content': Content,
    };


  }
  @override
  String toString() {
    return 'Texts{Content: $Content}';
  }

}


















//
// class Animation {
//   final String Path;
//
//   Animation({ required this.Path });
//
//   Map<String, Object?> toMap() {
//     return {
//       'Path': Path,
//     };
//
//
//   }
//   @override
//   String toString() {
//     return 'Animations{Path: $Path} ';
//   }
//
// }
//
//
//
// class Texte {
//
//   final String Content;
//
//   Texte({required this.Content});
//
//   Map<String, Object?> toMap() {
//     return {
//       'Content': Content,
//     };
//
//
//   }
//   @override
//   String toString() {
//     return 'Texts{Content: $Content}';
//   }
//
// }