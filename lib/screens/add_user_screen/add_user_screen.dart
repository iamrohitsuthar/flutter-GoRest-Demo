import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../../components/progress_dialog.dart';
import '../../config/config.dart';
import '../add_user_screen/components/add_user_form_component.dart';

class AddUserScreen extends StatefulWidget {
  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  AddUserFormComponent addUserFormComponent;

  void addUserData(BuildContext context, String name, String email,
      Gender gender, Status status) async {
    buildShowDialog(context); //show progress dialog

    Map body = {
      'name': name,
      'email': email,
      'gender': gender.toString().substring(gender.toString().indexOf('.') + 1),
      'status': status.toString().substring(status.toString().indexOf('.') + 1)
    };

    var response = await http.post(
      Uri.parse('https://gorest.co.in/public-api/users'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $GOREST_API_TOKEN",
      },
      body: json.encode(body),
    );

    var jsonResponse = json.decode(response.body);
    print(jsonResponse['code'].runtimeType);
    Navigator.of(context).pop(); // hide progress dialog

    if (jsonResponse['code'] == 201) {
      // user successfully added
      Fluttertoast.showToast(
        msg: "User added successfully",
        backgroundColor: Colors.green.shade400,
        textColor: Colors.black87,
      );
      addUserFormComponent.resetForm();
    } else if (jsonResponse['code'] == 422) {
      Fluttertoast.showToast(
        msg: jsonResponse['data'][0]['field'] +
            ' ' +
            jsonResponse['data'][0]['message'],
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Something went wrong",
        backgroundColor: Colors.red.shade400,
        textColor: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    addUserFormComponent = AddUserFormComponent(addUserData);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: addUserFormComponent,
    );
  }
}
