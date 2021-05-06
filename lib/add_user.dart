import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter name';
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please enter email';
                  else if (!EmailValidator.validate(value))
                    return 'Please enter valid email';
                  return null;
                },
              ),
              Row(
                children: [
                  Column(
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print('Make API request');
                  }
                },
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
