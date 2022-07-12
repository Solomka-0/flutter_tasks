import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/user.dart';

class UserInfoPage extends StatelessWidget {
  late User? userInfo;

  UserInfoPage({this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Информация о пользователе"),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "${userInfo?.name}",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: userInfo!.about!.isEmpty ? null : Text(
                  "${userInfo?.about}"),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
              trailing: Text('${userInfo?.country}'),
            ),
            ListTile(
              title: Text(
                '${userInfo?.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.phone, color: Colors.black,),
            ),
            !userInfo!.email!.isEmpty ?
            ListTile(
              title: Text(
                '${userInfo!.email}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.phone, color: Colors.black,),
            ) : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
