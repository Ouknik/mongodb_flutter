import 'package:custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mongo_flutter/mongo_model.dart';

class ResultaPage extends StatelessWidget {
  MongoDbModel message;
  ResultaPage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: CustomDialog(
        content: Text(
            'data :{first name: ${message.firstName} , last name: ${message.lastname} , adress : ${message.adress}'),
        title: Text(
          'ٍScanner Successful',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ),
        firstColor: Color(0xFF3CCF57),
        secondColor: Colors.white,
        headerIcon: Icon(
          Icons.check_circle_outline,
          size: 120.0,
          color: Colors.white,
        ),
      ),
    ));
  }
}
