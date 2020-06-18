import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_password/models/password.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

showPasswordDialog(BuildContext context, String password){
   return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Your password is:',style: new TextStyle(fontSize:22,fontWeight:FontWeight.w500)),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(password,textAlign:TextAlign.center,style:new TextStyle(fontSize:20,wordSpacing:1)),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('COPY PASSWORD'),
                  textColor: Theme.of(context).primaryColor,
                  padding: EdgeInsets.only(right: 50),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(text: password));
                    BotToast.showText(text:"Copy password success");
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('OK'),
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
}

class ListItem extends StatelessWidget {
  final PasswordModel pwd;
  const ListItem({Key key, this.pwd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Slidable.of(context).close();
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return sheetMenu(context: context, pwd: pwd);
          },
        );
      },
      child: Container(
        color: pwd.favourite == 1 ? Colors.grey[200] : Colors.white,
        child: new ListTile(
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
                pwd.name,
                style: new TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: new Container(
            padding: const EdgeInsets.only(top: 5.0),
            child: new Text(
              pwd.notes,
              style: new TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget sheetMenu({BuildContext context, PasswordModel pwd}) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showPasswordDialog(context, pwd.password);
            },
            child: new Container(
              child: new ListTile(
                leading: new Icon(Icons.trending_flat),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'View',
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
             Navigator.pushNamed(context, '/password-set');
            },
            child: new Container(
              child: new ListTile(
                leading: new Icon(Icons.edit),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Edit',
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showPasswordDialog(context, pwd.password);
            },
            child: new Container(
              child: new ListTile(
                leading: new Icon(Icons.visibility),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Show Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(new ClipboardData(text: pwd.password));
              BotToast.showText(text:"Copy password success");
              Navigator.pop(context);
            },
            child: new Container(
              child: new ListTile(
                leading: new Icon(Icons.content_copy),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Copy Password',
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(new ClipboardData(text: pwd.password));
              BotToast.showText(text:"Copy username success");
              Navigator.pop(context);
            },
            child: new Container(
              child: new ListTile(
                leading: new Icon(Icons.folder_shared),
                title: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      'Copy Username',
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
