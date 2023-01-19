class ListElementModel {
  bool checked = false;
  bool alreadyChecked = false;
  final int position;

  ListElementModel({required this.position});

  String get name => "P$position";
}
