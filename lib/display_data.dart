import 'package:flutter/material.dart';

import 'dbHelper/mongodb.dart';

class DisplayData extends StatefulWidget {
  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: MongoDatabase.getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    var totalData = snapshot.data.length;
                    print(snapshot.data.length);
                    return Center(child: Text(totalData.toString()));
                  } else {
                    return const Center(
                      child: Text("No data Available"),
                    );
                  }
                }
              })),
    );
  }
}
