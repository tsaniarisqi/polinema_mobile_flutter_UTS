class ArtistItem {
  int _id;
  String _name;

  /*Setter untuk memasukkan nilai
  getter untuk mengambil nilai */
  int get id => this._id;

  get name => this._name;
  set name(value) => this._name = value;

  // konstruktor versi 1
  ArtistItem(this._name);

  // konstruktor versi 2: konversi dari Map ke ArtistItem
  ArtistItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
  }

  // konversi dari ArtistItem ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    return map;
  }
}
