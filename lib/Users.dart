import 'package:flutter/material.dart';
import 'package:newproject/models/Service.dart';
import 'package:newproject/models/Users.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<User> _users;
  bool _loading;

  void initState() {
    super.initState();
    _loading = true;
    Service.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_loading ? 'Loading...' : 'users'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: null == _users ? 0 : _users.length,
              itemBuilder: (context, index) {
                User user = _users[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.grey),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                );
              },
            )));
  }
}
