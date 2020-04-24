import 'package:flutter/material.dart';

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
                   suffix: IconButton(
                      icon: Icon(Icons.autorenew),
                      color: Colors.grey,
                      onPressed: () => {},
                      tooltip: 'generate',
                    )
                ),
                obscureText: true,
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
                onSaved: (val) {
                  _password = val;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
