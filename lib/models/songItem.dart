class SongItem {
  int _id;
  String _title;
  String _artistName;
  String _writer;

  int get id => this._id;

  get title => this._title;
  set title(value) => this._title = value;

  get artistName => this._artistName;
  set artistName(value) => this._artistName = value;

  get writer => this._writer;
  set writer(value) => this._writer = value;

  // konstruktor versi 1
  SongItem(this._title, this._artistName, this._writer);

  // konstruktor versi 2: konversi dari Map ke SongItem
  SongItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._artistName = map['artistName'];
    this._writer = map['writer'];
  }

  // konversi dari SongItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['artistName'] = artistName;
    map['writer'] = writer;
    return map;
  }
}
