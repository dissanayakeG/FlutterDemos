import 'package:flutter/material.dart';
import 'package:newproject/models/Service.dart';
import 'package:newproject/models/photos.dart';

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  List<Photo> _photos;
  bool _loading;

  void initState() {
    super.initState();
    _loading = true;

    Service.getPhotos().then((photos) => {
          setState(() {
            _photos = photos;
            _loading = false;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'photos'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: null == _photos ? 0 : _photos.length,
            itemBuilder: (context, index) {
              Photo photo = _photos[index];
              return ListTile(
                leading: Container(
                  margin: EdgeInsets.all(0),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(photo.thumbnailUrl),
                        fit: BoxFit.fill),
                  ),
                ),
                title: Text(photo.title),
                subtitle: Text(photo.url),
              );
            },
          )),
    );
  }
}
