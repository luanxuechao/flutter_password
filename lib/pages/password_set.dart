import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';

class PasswordSet extends StatefulWidget {
  @override
  PasswordSetState createState() {
    return new PasswordSetState();
  }
}

class PasswordSetState extends State<PasswordSet> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _name;

  String _password;
  bool visible =true;
  bool _favourite = false;
  bool _requiredPassword = false;
  void _forSubmitted() {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      print(_name);
      print(_password);
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
            onPressed: () => {},
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
                onSaved: (val) {
                  _name = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'URL:',
                ),
                validator: (val) {
                  return val.length < 4 ? "密码长度错误" : null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Username:',
                ),
                validator: (val) {
                  return val.length < 4 ? "密码长度错误" : null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                    labelText: 'Password:',
                    isDense: true,
                    contentPadding: EdgeInsets.only(top: 5),
                    suffix: IconButton(
                      icon: Icon(visible?CustomIcon.NotVisible :CustomIcon.Browse),
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
                  return val.length < 4 ? "密码长度错误" : null;
                },
                onSaved: (val) {
                  _password = val;
                },
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Notes:',
                ),
                validator: (val) {
                  return val.length < 4 ? "密码长度错误" : null;
                },
                maxLines: 3,
                onSaved: (val) {
                  _password = val;
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
