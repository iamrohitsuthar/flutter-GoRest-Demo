import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import './home_card.dart';
import './add_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data;

  @override
  void initState() {
    super.initState();
    this.getUsersData();
  }

  void handlePopupMenuClick(String item) {
    switch (item) {
      case 'Edit':
        print('Edit Clicked');
        break;
      case 'Delete':
        print('Delete Clicked');
        break;
    }
  }

  void getUsersData({int page = 0}) async {
    var response = await get(
        Uri.parse('https://gorest.co.in/public-api/users?page=$page'));

    setState(() {
      var jsonData = json.decode(response.body);
      data = jsonData['data'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('GoRest Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddUser()),
          );
        },
      ),
      body: (data == null)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int i) {
                return HomeCard(
                  userId: data.elementAt(i)['id'],
                  userEmail: data.elementAt(i)['email'],
                  userName: data.elementAt(i)['name'],
                  gender: data.elementAt(i)['gender'],
                  status: data.elementAt(i)['status'],
                  createdAt: data.elementAt(i)['created_at'].substring(
                      0, data.elementAt(i)['created_at'].indexOf('T')),
                  updateAt: data.elementAt(i)['updated_at'].substring(
                      0, data.elementAt(i)['updated_at'].indexOf('T')),
                  handlePopupMenuClick: handlePopupMenuClick,
                );
              },
            ),
    );
  }
}
