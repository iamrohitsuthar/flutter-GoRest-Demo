import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

enum Gender { Male, Female }
enum Status { Active, Inactive }

class AddUserFormComponent extends StatefulWidget {
  final Function addUserData;
  final _AddUserFormComponentState _addUserFormComponentState =
      _AddUserFormComponentState();

  AddUserFormComponent(this.addUserData);

  void resetForm() {
    _addUserFormComponentState.resetForm();
  }

  @override
  _AddUserFormComponentState createState() => _addUserFormComponentState;
}

class _AddUserFormComponentState extends State<AddUserFormComponent> {
  final _formKey = GlobalKey<FormState>();
  Gender _gender = Gender.Male;
  Status _status = Status.Active;
  String _name;
  String _email;

  void resetForm() {
    setState(() {
      _formKey.currentState.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      //addUserData(context);
                      widget.addUserData(
                          context, _name, _email, _gender, _status);
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
    );
  }
}
