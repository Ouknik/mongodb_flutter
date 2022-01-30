import 'dart:developer';
import 'package:mongo_dart/mongo_dart.dart';
import '../mongo_model.dart';
import 'constant.dart';

class MongoDatabase {
  static var db, userCollection;
  static connect() async {
    db = await Db.create(MONGO_ConNNURL);
    await db.open();
    inspect(db);
    userCollection = db.collection(USER_COLLUCTIOn);
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final arrData = await userCollection.find().toList();
    return arrData;
  }

  static Future<String> insert(MongoDbModel data) async {
    try {
      var result = await userCollection.insertOne(data.toJson());
      if (result.isSuccess) {
        return "data Insered";
      } else {
        return "data is not  Insered";
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
