import 'package:flutter/material.dart';
import 'package:flutter_task/db/database.dart';
import 'package:flutter_task/model/list_element_model.dart';
import 'package:flutter_task/model/p_model.dart';
import 'package:flutter_task/model/product.dart';
import 'package:flutter_task/pages/third_page.dart';

class SecondPage extends StatefulWidget {
  final List<ListElementModel> checkedList;

  const SecondPage({super.key, required this.checkedList});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List<Product>> productsList;
  List<Map<String, dynamic>> productMapList = [];

  @override
  void initState() {
    super.initState();
    _getProducts();
  }

  _getProducts() {
    setState(() {
      productsList = DBProvider.db.findProducts(1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // DBProvider.db.deleteProducts();
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Expanded(
          child: FutureBuilder(
            future: productsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ProductElement(
                        model: snapshot.data![index],
                        productMapList: productMapList);
                  },
                );
              } else if (snapshot.hasError) {
                return const Text(
                  "No Data",
                  style: TextStyle(fontSize: 18.0),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          Route route = MaterialPageRoute(
            builder: (context) => ThirdPage(
              pModel: PModel(previousMapList: productMapList),
            ),
          );
          Navigator.push(context, route);
        },
      ),
    );
  }
}

class ProductElement extends StatefulWidget {
  final Product model;
  List<Map<String, dynamic>> productMapList;

  ProductElement(
      {super.key, required this.model, required this.productMapList});

  @override
  State<ProductElement> createState() => _ProductElementState();
}

class _ProductElementState extends State<ProductElement> {
  void _addToListOfMap() {
    setState(() {
      widget.productMapList.add(widget.model.toMap());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.model.product,
            style: const TextStyle(fontSize: 18.0),
          ),
          IconButton(
            onPressed: () {
              _addToListOfMap();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
