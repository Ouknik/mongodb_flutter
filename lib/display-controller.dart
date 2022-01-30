//import 'package:get/get.dart';
//import 'dbHelper/mongodb.dart';
//import 'mongo_model.dart';
//class HomeController extends GetxController {
//  HomeController() {
//    getData();
//  }
//  List<MongoDbModel> data = [];
//
//  getData() async {
//    var helpear = (await MongoDatabase.getData());
//    for (int i = 0; i < helpear.length; i++) {
//      data.add(MongoDbModel.fromJson(helpear[i]));
//      print(data[i].lastname);
//    }
//    print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
//    print(data.length);
//  }
//}
//