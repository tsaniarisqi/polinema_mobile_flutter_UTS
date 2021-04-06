import 'package:daftar_lagu/pages/artist.dart';
import 'package:daftar_lagu/pages/song.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 120,
              margin: EdgeInsets.only(right: 10),
              child: RaisedButton(
                color: Colors.yellow[600],
                child: Text("Song", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Song()),
                  );
                },
              ),
            ),
            Container(
              height: 60,
              width: 120,
              margin: EdgeInsets.only(left: 10),
              child: RaisedButton(
                color: Colors.yellow[600],
                child: Text("Artist", style: TextStyle(fontSize: 20)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Artist()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
