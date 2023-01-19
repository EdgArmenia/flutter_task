import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/p_model.dart';

class ThirdPage extends StatelessWidget {
  final PModel pModel;

  ThirdPage({super.key, required this.pModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: pModel.newMap.length,
            itemBuilder: (context, index) {
              return ListViewElement(
                map: pModel.newMap,
                mapKey: "p${index + 1}",
              );
            },
          ),
        ),
      ),
    );
  }
}

class ListViewElement extends StatelessWidget {
  final String mapKey;
  final Map<String, dynamic> map;
  const ListViewElement({
    super.key,
    required this.mapKey,
    required this.map,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          map[mapKey].isNotEmpty
              ? Text(
                  mapKey,
                  style: TextStyle(fontSize: 18),
                )
              : const Text(" "),
          ListView.builder(
            shrinkWrap: true,
            itemCount: map[mapKey].length,
            itemBuilder: ((context, index) {
              return Text("\t\t${map[mapKey][index]}");
            }),
          ),
        ],
      ),
    );
  }
}
