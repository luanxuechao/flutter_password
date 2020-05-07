import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';
import 'package:flutter_password/models/password.dart';
import '../models/chat_model.dart';
import 'package:flutter_password/dao/passwordDao.dart';

class PasswordList extends StatefulWidget {
  @override
  PasswordListState createState() {
    return new PasswordListState();
  }
}

class PasswordListState extends State<PasswordList> {
  List<PasswordModel> pwdList = null;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    PasswordDao pwdDao = new PasswordDao();

    List<PasswordModel> ret = await pwdDao.findAll();
    setState(() {
      pwdList = ret;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (pwdList == null) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  <Widget>[
          Icon(
            CustomIcon.Empty,
            color: Colors.grey[300],
            size: 180.0,
          ),
        ],
      );
    }
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: pwdList == null ? 0 : pwdList.length,
      itemBuilder: (context, i) => new Column(
        children: <Widget>[
          new Divider(
            height: 20.0,
          ),
          new ListTile(
            leading: new CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              backgroundImage: new NetworkImage(
                  "http://www.usanetwork.com/sites/usanetwork/files/styles/629x720/public/suits_cast_harvey.jpg?itok=fpTOeeBb"),
            ),
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  pwdList[i].name,
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
                new Text(
                  pwdList[i].password,
                  style: new TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: new Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: new Text(
                pwdList[i].notes,
                style: new TextStyle(color: Colors.grey, fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
