import 'package:daftar_lagu/form/songentryform.dart';
import 'package:daftar_lagu/helpers/dbhelper.dart';
import 'package:daftar_lagu/models/songItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';

class Song extends StatefulWidget {
  @override
  SongState createState() => SongState();
}

class SongState extends State<Song> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<SongItem> itemList;

  @override
  // untuk menampilkan data yang sudah diisikan
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Song'),
      ),
      body: Column(
        children: [
          Expanded(
            child: createListView(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
        tooltip: 'Add Song',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertSongItem(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Future<SongItem> navigateToEntryForm(
      BuildContext context, SongItem songItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SongEntryForm(songItem);
        },
      ),
    );
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          margin: EdgeInsets.all(8),
          child: ListTile(
            // widget yang akan menampilkan sebelum title
            leading: CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(Icons.music_note),
            ),
            title: Text(
              this.itemList[index].title,
              style: textStyle,
            ),
            subtitle: Text(
              this.itemList[index].artistName,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
            // widget yang akan menampilkan setelah title
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () async {
                    var item = await navigateToEntryForm(
                        context, this.itemList[index]);
                    //TODO 4 Panggil Fungsi untuk Edit data
                    if (item != null) editItem(item);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                    deleteItem(itemList[index]);
                  },
                ),
              ],
            ),
            onTap: () async {
              // untuk manmpilkan pop up detai song
              showDialog(
                context: context,
                builder: (BuildContext context) =>
                    _buildPopupDialog(context, index),
              );
            },
          ),
        );
      },
    );
  }

  // Pop detail dong 
  Widget _buildPopupDialog(BuildContext context, int index) {
    return new AlertDialog(
      title: const Text(
        'Detail Song',
        textAlign: TextAlign.center,
      ),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Title: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            this.itemList[index].title,
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Text(
            "Performed by: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            this.itemList[index].artistName,
          ),
          Padding(padding: EdgeInsets.only(top: 20.0)),
          Text(
            "Written by: ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            this.itemList[index].writer,
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text('Close', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
        ),
      ],
    );
  }

  //delete Item
  void deleteItem(SongItem object) async {
    int result = await dbHelper.deleteSongItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(SongItem object) async {
    int result = await dbHelper.updateSongItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<SongItem>> itemListFuture = dbHelper.getSongItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
