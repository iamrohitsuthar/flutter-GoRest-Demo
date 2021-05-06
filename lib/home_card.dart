import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final Function handlePopupMenuClick;

  HomeCard(this.handlePopupMenuClick);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#1890',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Color(0xff35364F),
                      fontSize: 14),
                ),
                Container(
                  transform: Matrix4.translationValues(22.0, -12.0, 0.0),
                  child: PopupMenuButton(
                    icon: GestureDetector(
                      child: Icon(Icons.more_vert),
                    ),
                    padding: EdgeInsets.zero,
                    onSelected: handlePopupMenuClick,
                    itemBuilder: (BuildContext context) {
                      return {'Edit', 'Delete'}.map((e) {
                        return PopupMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Text(
                'Alden Cantreel',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff35364F),
                    fontSize: 16),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Text(
                'aldencanreel@gmail.com',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xff35364F),
                    fontSize: 16),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -10.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Male',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff35364F),
                            fontSize: 16),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade400,
                            fontSize: 16),
                      ),
                      Text(
                        'Active',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            color: Color(0xff35364F),
                            fontSize: 16),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Created at: ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 12),
                          ),
                          Text(
                            '2021-05-02',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Updated at: ',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 12),
                          ),
                          Text(
                            '2021-05-02',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade400,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
