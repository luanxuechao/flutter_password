import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';
import 'package:flutter_password/models/password.dart';
import 'package:flutter_password/dao/passwordDao.dart';

class PasswordSet extends StatefulWidget {
  @override
  PasswordSetState createState() {
    return new PasswordSetState();
  }
}

class PasswordSetState extends State<PasswordSet> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _name;
  String _url;
  String _username;
  String _password;
  String _notes;
  bool visible = true;
  bool _favourite = false;
  bool _requiredPassword = false;
  _forSubmitted() async {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      int favourite = _favourite ? 1 : 0;
      int passwordRepormpt = _requiredPassword ? 1 : 0;
      int updatedAt =
          ((new DateTime.now()).millisecondsSinceEpoch / 1000).round();
      PasswordModel pwd = PasswordModel(
          name: _name,
          url: _url,
          username: _username,
          password: _password,
          notes: _notes,
          favourite: favourite,
          passwordRepormpt: passwordRepormpt,
          updatedAt: updatedAt);
      PasswordDao pwdDao = PasswordDao();
      int ret = await pwdDao.insert(pwd);
      if (ret > 0) {
        return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('info'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('success'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('comfirm'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                    Navigator.pop(context,"");
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  // String dropdownValue = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Password'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            color: Colors.white,
            onPressed: _forSubmitted,
            tooltip: 'saved',
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            tooltip: "",
            padding: EdgeInsets.all(0.0),
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                  child: Text("generate"),
                  value: "hot",
                ),
                PopupMenuItem<String>(
                  child: Text("delete"),
                  value: "new",
                ),
              ];
            },
            onSelected: (String action) {
              switch (action) {
                case "hot":
                  break;
                case "new":
                  break;
              }
            },
            onCanceled: () {
              print("onCanceled");
            },
          )
        ],
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new Column(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Name:',
                ),
                validator: (val) {
                  return val.length < 1 ? '名称不能为空' : null;
                },
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'URL:',
                ),
                onSaved: (val) {
                  _url = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Username:',
                ),
                validator: (val) {
                  return val.length < 1 ? "用户名不能为空" : null;
                },
                onSaved: (val) {
                  _username = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    labelText: 'Password:',
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 5),
                    suffix: IconButton(
                      icon: Icon(
                          visible ? CustomIcon.NotVisible : CustomIcon.Browse),
                      onPressed: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      padding: EdgeInsetsDirectional.only(end: 10.0),
                    ),
                    suffixStyle: TextStyle(height: 0.1)),
                obscureText: visible,
                validator: (val) {
                  return val.length < 1 ? "密码不能为空" : null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Notes:',
                ),
                maxLines: 3,
                onSaved: (val) {
                  _notes = val;
                },
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _favourite,
                    onChanged: (bool newValue) {
                      setState(() {
                        _favourite = !_favourite;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: new Color(0xff075E54),
                  ),
                  Expanded(child: Text('Favourite')),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _requiredPassword,
                    onChanged: (bool newValue) {
                      setState(() {
                        _requiredPassword = newValue;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: new Color(0xff075E54),
                  ),
                  Expanded(child: Text('Require Password Repormpt')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
