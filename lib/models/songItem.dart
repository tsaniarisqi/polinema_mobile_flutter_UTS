class SongItem {
  int _songId;
  int _albumId;
  int _artistId;
  String _title;
  String _writer;

  int get songId => this._songId;

  get albumId => this._albumId;

  get artistId => this._artistId;
  
  get title => this._title;
  set title(value) => this._title = value;
  
  get writer => this._writer;
  set writer(value) => this._writer = value;

  // konstruktor versi 1
  SongItem(this._title, this._writer);

  // konstruktor versi 2: konversi dari Map ke SongItem
  SongItem.fromMap(Map<String, dynamic> map) {
    this._songId =map['songId'];
    this._albumId = map['albumId'];
    this._artistId = map['artistId'];
    this._title = map['title'];
    this._writer = map['writer'];
  }

  // konversi dari SongItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['songId'] = this._songId;
    map['albumId'] = this._albumId;
    map['artistId'] = this._artistId;
    map['title'] = title;
    map['writer'] = writer;
    return map;
  }
}
