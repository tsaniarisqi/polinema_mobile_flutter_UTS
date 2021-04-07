import 'package:daftar_lagu/helpers/dbhelper.dart';
import 'package:daftar_lagu/models/artistItem.dart';
import 'package:daftar_lagu/models/songItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class SongEntryForm extends StatefulWidget {
  final SongItem songItem;
  SongEntryForm(this.songItem);
  @override
  SongEntryFormState createState() => SongEntryFormState(this.songItem);
}

class SongEntryFormState extends State<SongEntryForm> {
  SongItem songItem;
  ArtistItem artistItem;
  DbHelper dbHelper = DbHelper();
  SongEntryFormState(this.songItem);

  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();

  List<ArtistItem> artistList = List<ArtistItem>();
  List<String> listArtist = List<String>();

  int indexList = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<ArtistItem>> artistListFuture = dbHelper.getArtistItemList();
      artistListFuture.then((artistList) {
        setState(() {
          for (int i = 0; i < artistList.length; i++) {
            listArtist.add(artistList[i].name);
          }
        });
      });
    });
  }

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
            // artist name
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Artist',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                value: listArtist[indexList],
                items: listArtist.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  int i = listArtist.indexOf(value);
                  setState(() {
                    indexList = i;
                  });
                },
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
                      color: Colors.yellow[600],
                      child: Text(
                        'Save',
                        textScaleFactor: 1,
                      ),
                      onPressed: () {
                        if (songItem == null) {
                          // tambah data
                          songItem = SongItem(
                            titleController.text,
                            listArtist[indexList].toString(),
                            writerController.text,
                          );
                        } else {
                          // ubah data
                          songItem.title = titleController.text;
                          songItem.artistName =
                              listArtist[indexList].toString();
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
                      color: Colors.yellow[600],
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1,
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
