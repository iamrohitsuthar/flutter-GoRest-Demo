import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';

import './components/home_card_component.dart';
import '../add_user_screen/add_user_screen.dart';
import '../../models/user.dart';
import '../../config/config.dart';
import '../../components/progress_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> data;
  BuildContext context;

  @override
  void initState() {
    super.initState();
    data = [];
    this.getUsersData();
  }

  void deleteUser(int userid) async {
    print('delete request: $userid');
    buildShowDialog(context); // show progress dialog

    var response = await http.delete(
      Uri.parse('https://gorest.co.in/public-api/users/$userid'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $GOREST_API_TOKEN",
      },
    );
    var jsonResponse = json.decode(response.body);
    Navigator.of(context).pop(); // hide progress dialog
    if (jsonResponse['code'] == 204) {
      Fluttertoast.showToast(
        msg: "User deleted successfully",
        backgroundColor: Colors.green.shade400,
        textColor: Colors.black87,
      );
      setState(() {
        for (int i = 0; i < data.length; i++) {
          if (data.elementAt(i).id == userid) {
            data.removeAt(i);
            break;
          }
        }
      });
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
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
    });
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Text('GoRest Demo'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {},
          )
        ],
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
                  deleteUser: deleteUser,
                );
              },
            ),
    );
  }
}
