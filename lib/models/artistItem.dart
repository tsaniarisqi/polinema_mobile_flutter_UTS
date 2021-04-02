class ArtistItem {
  int _id;
  String _artistName;

  /*Setter untuk memasukkan nilai
  getter untuk mengambil nilai */
  int get id => this._id;

  get artistName => this._artistName;
  set artistName(value) => this._artistName = value;

  // konstruktor versi 1
  ArtistItem(this._artistName);

  // konstruktor versi 2: konversi dari Map ke ArtistItem
  ArtistItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._artistName = map['artistName'];
  }

  // konversi dari ArtistItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['artistName'] = artistName;
    return map;
  }
}
