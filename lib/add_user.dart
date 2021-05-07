import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import './progress_dialog.dart';
import './config.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

enum Gender { Male, Female }
enum Status { Active, Inactive }

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  Gender _gender = Gender.Male;
  Status _status = Status.Active;
  String _name;
  String _email;

  void addUserData(BuildContext context) async {
    buildShowDialog(context); //show progress dialog

    Map body = {
      'name': _name,
      'email': _email,
      'gender':
          _gender.toString().substring(_gender.toString().indexOf('.') + 1),
      'status':
          _status.toString().substring(_status.toString().indexOf('.') + 1)
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
      setState(() {
        FocusScope.of(context).unfocus();
        _formKey.currentState.reset();
      });
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter name';
                    _name = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return 'Please enter email';
                    else if (!EmailValidator.validate(value))
                      return 'Please enter valid email';
                    _email = value;
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                value: Gender.Male,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                            Text('Male'),
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                value: Status.Active,
                                groupValue: _status,
                                onChanged: (Status value) {
                                  setState(() {
                                    _status = value;
                                  });
                                },
                              ),
                            ),
                            Text('Active'),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                value: Gender.Female,
                                groupValue: _gender,
                                onChanged: (Gender value) {
                                  setState(() {
                                    _gender = value;
                                  });
                                },
                              ),
                            ),
                            Text('Female')
                          ],
                        ),
                        Row(
                          children: [
                            Transform.scale(
                              scale: 1.5,
                              child: Radio(
                                value: Status.Inactive,
                                groupValue: _status,
                                onChanged: (Status value) {
                                  setState(() {
                                    _status = value;
                                  });
                                },
                              ),
                            ),
                            Text('Inactive')
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addUserData(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Text(
                        'Add',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
