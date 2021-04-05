import 'package:daftar_lagu/form/artistentryform.dart';
import 'package:daftar_lagu/helpers/dbHelper.dart';
import 'package:daftar_lagu/models/artistItem.dart';
import 'package:daftar_lagu/pages/song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Artist extends StatefulWidget {
  @override
  ArtistState createState() => ArtistState();
}

class ArtistState extends State<Artist> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<ArtistItem> itemList;

  @override
  // untuk menampilkan data yang sudah diisikan
  void initState() {
    super.initState();
    updateListView();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList == null) {
      itemList = List<ArtistItem>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Artist'),
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
        tooltip: 'Add Artist',
        onPressed: () async {
          var item = await navigateToEntryForm(context, null);
          if (item != null) {
            //TODO 2 Panggil Fungsi untuk Insert ke DB
            int result = await dbHelper.insertArtistItem(item);
            if (result > 0) {
              updateListView();
            }
          }
        },
      ),
    );
  }

  Future<ArtistItem> navigateToEntryForm(
      BuildContext context, ArtistItem artistItem) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ArtistEntryForm(artistItem);
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
              child: Icon(Icons.account_circle),
            ),
            title: Text(
              this.itemList[index].name,
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
  void deleteItem(ArtistItem object) async {
    int result = await dbHelper.deleteArtistItem(object.id);
    if (result > 0) {
      updateListView();
    }
  }

  //edit data
  void editItem(ArtistItem object) async {
    int result = await dbHelper.updateArtistItem(object);
    if (result > 0) {
      updateListView();
    }
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<ArtistItem>> itemListFuture = dbHelper.getArtistItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
