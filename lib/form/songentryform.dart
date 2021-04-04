import 'package:daftar_lagu/models/songItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SongEntryForm extends StatefulWidget {
  final SongItem songItem;
  SongEntryForm(this.songItem);
  @override
  SongEntryFormState createState() => SongEntryFormState(this.songItem);
}

class SongEntryFormState extends State<SongEntryForm> {
  SongItem songItem;
  SongEntryFormState(this.songItem);
  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //kondisi
    if (songItem != null) {
      titleController.text = songItem.title;
      writerController.text = songItem.writer;
    }
    //rubah
    return Scaffold(
      appBar: AppBar(
        title: songItem == null ? Text('Tambah') : Text('Ubah'),
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
            //title
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            //writer
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: writerController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Writer',
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
                        if (songItem == null) {
                          // tambah data
                          songItem = SongItem(
                            titleController.text,
                            writerController.text,
                          );
                        } else {
                          // ubah data
                          songItem.title = titleController.text;
                          songItem.writer = writerController.text;
                        }
                        // kembali ke layar sebelumnya dengan membawa objek item
                        Navigator.pop(context, songItem);
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
