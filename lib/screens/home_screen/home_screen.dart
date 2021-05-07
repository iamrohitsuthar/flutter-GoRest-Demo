import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'components/home_card_component.dart';
import '../add_user_screen/add_user_screen.dart';
import '../../models/user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> data;

  @override
  void initState() {
    super.initState();
    data = [];
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
    var response = await http
        .get(Uri.parse('https://gorest.co.in/public-api/users?page=$page'));

    setState(() {
      Map<String, dynamic> jsonData = json.decode(response.body);

      List<dynamic> users = jsonData['data'];
      users.forEach((element) {
        data.add(
          User(
            element['id'],
            element['name'],
            element['email'],
            element['gender'],
            element['status'],
            element['created_at']
                .substring(0, element['created_at'].indexOf('T')),
            element['updated_at']
                .substring(0, element['created_at'].indexOf('T')),
          ),
        );
      });

      //data = jsonData['data'];
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
            MaterialPageRoute(builder: (context) => AddUserScreen()),
          );
        },
      ),
      body: (data.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int i) {
                return HomeCardComponent(
                  user: data.elementAt(i),
                  handlePopupMenuClick: handlePopupMenuClick,
                );
              },
            ),
    );
  }
}
