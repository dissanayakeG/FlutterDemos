import 'package:flutter/material.dart';
import 'package:newproject/Photos.dart';
import 'package:newproject/TextInputs.dart';
import 'package:newproject/Users.dart';

void main() => runApp(MaterialApp(
        home: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Flutter tests'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('rest api simple model'),
              ),
              Tab(
                child: Text('resp api model complex'),
              ),
              Tab(
                child: Text('Text inputs'),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [UserList(), PhotoList(), TextInputs()],
        ),
      ),
    )));
