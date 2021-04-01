class AlbumItem {
  int _albumId;
  int _artistId;
  String _albumName;
  int _released;

  int get albumId => this._albumId;

  get artistId => this._artistId;

  get albumName => this._albumName;
  set albumName(value) => this._albumName = value;

  get released => this._released;
  set released(value) => this._released = value;

  // konstruktor versi 1
  AlbumItem(this._albumName, this._released);

  // konstruktor versi 2: konversi dari Map ke AlbumItem
  AlbumItem.fromMap(Map<String, dynamic> map) {
    this._albumId = map['albumId'];
    this._artistId = map['artistId'];
    this._albumName = map['albumName'];
    this._released = map['released'];
  }

  // konversi dari AlbumItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['albumId'] = this._albumId;
    map['artistId'] = this._artistId;
    map['albumName'] = albumName;
    map['released'] = released;
    return map;
  }
}
