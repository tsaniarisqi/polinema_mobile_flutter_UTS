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
    if (itemList == null) {
      itemList = List<SongItem>();
    }
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
          ),
        );
      },
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
