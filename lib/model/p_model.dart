class PModel {
  List<Map<String, dynamic>> previousMapList;
  late Map<String, dynamic> newMap;

  PModel({required this.previousMapList}) {
    _initNewMapList();
    _modernMap();
  }

  void _initNewMapList() {
    newMap = {
      "p1": [],
      "p2": [],
    };
  }

  void _modernMap() {
    for (int i = 0; i < previousMapList.length; i++) {
      if (previousMapList[i]["p1"] == 1) {
        newMap["p1"].add(previousMapList[i]["product"]);
      }
      if (previousMapList[i]["p2"] == 1) {
        newMap["p2"].add(previousMapList[i]["product"]);
      }
    }
    //   newMapList.add({
    //   "p1": [element]
    // });
  }
}
