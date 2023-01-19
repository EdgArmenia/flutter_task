import 'package:flutter/material.dart';
import 'package:flutter_task/db/database.dart';
import 'package:flutter_task/model/list_element_model.dart';
import 'package:flutter_task/model/products_list.dart';
import 'package:flutter_task/pages/second_page.dart';

import '../model/product.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final List<ListElement> _widgetsList = [];
  List<ListElementModel> checkedList = [];

  @override
  void initState() {
    super.initState();
    _initWidgetList();
    _initDB();
  }

  void _initDB() {
    DBProvider.db.deleteProducts();
  }

  void _initWidgetList() {
    setState(() {
      _widgetsList.add(ListElement(model: ListElementModel(position: 1)));
      _widgetsList.add(ListElement(model: ListElementModel(position: 2)));
    });
  }

  void _addToCheckedList() {
    setState(() {
      checkedList = _widgetsList.map((element) => element.model).toList();
    });
  }

  void _addToDB() {
    ProductsList productsList = ProductsList();
    for (int i = 0; i < checkedList.length; i++) {
      if (checkedList[i].checked && checkedList[i].alreadyChecked) {
        checkedList[i].alreadyChecked = true;
        DBProvider.db.insertProduct(productsList.list[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: _widgetsList.length,
          itemBuilder: (context, index) {
            return _widgetsList[index];
          },
        )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          _addToCheckedList();
          _addToDB();
          Route route = MaterialPageRoute(
              builder: (context) => SecondPage(checkedList: checkedList));
          Navigator.push(context, route);
        },
      ),
    );
  }
}

class ListElement extends StatefulWidget {
  final ListElementModel model;
  const ListElement({super.key, required this.model});

  @override
  State<ListElement> createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  void _changeChecked() {
    setState(() {
      widget.model.checked = !widget.model.checked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: _changeChecked,
          icon: widget.model.checked
              ? const Icon(Icons.check_box)
              : const Icon(Icons.check_box_outline_blank),
        ),
        const SizedBox(width: 8),
        Text(
          widget.model.name,
          style: const TextStyle(fontSize: 18.0),
        )
      ],
    );
  }
}
