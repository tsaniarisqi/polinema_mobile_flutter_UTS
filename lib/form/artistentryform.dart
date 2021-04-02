import 'package:daftar_lagu/models/artistItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArtistEntryForm extends StatefulWidget {
  final ArtistItem artistItem;
  ArtistEntryForm(this.artistItem);
  @override
  ArtistEntryFormState createState() => ArtistEntryFormState(this.artistItem);
}

class ArtistEntryFormState extends State<ArtistEntryForm> {
  ArtistItem artistItem;
  ArtistEntryFormState(this.artistItem);
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (artistItem != null) {
      nameController.text = artistItem.name;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: artistItem == null ? Text('Tambah') : Text('Ubah'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            //artistName
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Artist Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            // button
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  // tombol simpan
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (artistItem == null) {
                          // tambah data
                          artistItem = ArtistItem(
                            nameController.text,
                          );
                        } else {
                          // ubah data
                          artistItem.name = nameController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, artistItem);
                      },
                    ),
                  ),
                  Container(
                    width: 5.0,
                  ),
                  // tombol batal
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
