class SongItem {
  int _id;
  int _artistId;
  String _title;
  String _writer;

  int get id => this._id;

  get artistId => this._artistId;

  get title => this._title;
  set title(value) => this._title = value;

  get writer => this._writer;
  set writer(value) => this._writer = value;

  // konstruktor versi 1
  SongItem(this._title, this._writer);

  // konstruktor versi 2: konversi dari Map ke SongItem
  SongItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._artistId = map['artistId'];
    this._title = map['title'];
    this._writer = map['writer'];
  }

  // konversi dari SongItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['artistId'] = this._artistId;
    map['title'] = title;
    map['writer'] = writer;
    return map;
  }
}
