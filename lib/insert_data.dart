import 'dart:ffi';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart' as m;

import 'dbHelper/mongodb.dart';
import 'display-controller.dart';
import 'mongo_model.dart';
import 'qr/qr_scanner.dart';

class InsertData extends StatefulWidget {
  InsertData({Key? key}) : super(key: key);

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  var fnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var adressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Text('insert Data'),
            TextField(
              controller: fnameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: lastnameController,
              decoration: InputDecoration(labelText: 'last Name'),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: adressController,
              decoration: InputDecoration(labelText: 'adress'),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                    onPressed: () {
                      _fakedta();
                    },
                    child: Text("Generate Data")),
                ElevatedButton(
                    onPressed: () {
                      _insertData(fnameController.text, lastnameController.text,
                          adressController.text);
                    },
                    child: Text("Insert data")),
              ],
            )
          ],
        )),
      ),
    );
  }

  Future<void> _insertData(String fName, String LName, String adres) async {
    var _id = m.ObjectId();
    final data =
        MongoDbModel(id: _id, firstName: fName, lastname: LName, adress: adres);
    var resulta = await MongoDatabase.insert(data);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Insert Id' + _id.$oid)));
    _clearAll();
  }

  void _clearAll() {
    fnameController.clear();
    lastnameController.clear();

    adressController.clear();
  }

  void _fakedta() {
    fnameController.text = faker.person.firstName();
    lastnameController.text = faker.person.lastName();

    adressController.text =
        faker.address.streetName() + "\n" + faker.address.streetAddress();
  }
}
