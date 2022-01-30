import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

//MongoDbModel mongoDbModelFromJson(String str)=>MongoDbModel.fromJson(json.decoder(str));
//String mongoDbModelToJson(MongoDbModel data)=>json.encoder(data.toJson());
class MongoDbModel {
  late String firstName, lastname, adress;
  late ObjectId id;
  MongoDbModel(
      {required this.id,
      required this.firstName,
      required this.lastname,
      required this.adress});
  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastname: json["lastname"],
        adress: json["adress"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastname": lastname,
        "adress": adress,
      };
}
