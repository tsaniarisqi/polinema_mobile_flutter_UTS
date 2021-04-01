class ArtistItem {
  int _artistId;
  String _artistName;

  /*Setter untuk memasukkan nilai
  getter untuk mengambil nilai */
  int get artistId => this._artistId;

  get artistName => this._artistName;
  set artistName(value) => this._artistName = value;

  // konstruktor versi 1
  ArtistItem(this._artistName);

  // konstruktor versi 2: konversi dari Map ke ArtistItem
  ArtistItem.fromMap(Map<String, dynamic> map) {
    this._artistId = map['artistId'];
    this._artistName = map['artistName'];
  }

  // konversi dari ArtistItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['artistId'] = this._artistId;
    map['artistName'] = artistName;
    return map;
  }
}
