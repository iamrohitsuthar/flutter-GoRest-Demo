import 'package:flutter/material.dart';
import './home_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> names = ["Rohit", "Anna", "Ema"];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GoRest Demo'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          print('fab clicked');
        },
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 8, bottom: 8),
        itemCount: names.length,
        itemBuilder: (BuildContext context, int i) {
          return HomeCard(handlePopupMenuClick);
        },
      ),
    );
  }
}
