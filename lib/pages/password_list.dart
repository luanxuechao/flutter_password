import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';
import 'package:flutter_password/models/password.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  void deactivate() {
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      getData();
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  _showSnackBar(String action) {
    // BotToast.showSimpleNotification(title: '当前点击按钮：$action');
  }

  void getData() async {
    PasswordDao pwdDao = new PasswordDao();

    List<PasswordModel> ret = await pwdDao.findAll();
    setState(() {
      pwdList = ret;
    });
  }

  void deleteData(int id) async {
    PasswordDao pwdDao = new PasswordDao();
    await pwdDao.deleteById(id);
    getData();
  }

  void likeData(PasswordModel pwd) async {
    PasswordDao pwdDao = new PasswordDao();
    pwd.favourite = pwd.favourite == 1 ? 0 : 1;
    PasswordModel updateItem = PasswordModel(
      favourite: pwd.favourite,
    );
    await pwdDao.updateById(pwd.id, updateItem);
    getData();
  }

  // @override
  Widget build(BuildContext context) {
    if (pwdList == null) {
      return new Padding(
          padding: new EdgeInsets.only(top: 160),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                CustomIcon.Empty,
                color: Colors.grey[300],
                size: 180.0,
              ),
            ],
          ));
    }
    return new ListView.builder(
      shrinkWrap: true,
      itemCount: pwdList == null ? 0 : pwdList.length,
      itemBuilder: (context, i) => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          renderItemType(
              pwd: pwdList[i], actionType: SlidableBehindActionPane()),
        ],
      ),
    );
  }

  Widget renderItemType({PasswordModel pwd, Widget actionType}) {
    return Slidable(
      actionPane: actionType,
      actionExtentRatio: 0.25,
      child: ListItem(pwd: pwd),
      secondaryActions: <Widget>[
        //右侧按钮列表r
        IconSlideAction(
          caption: pwd.favourite == 1 ? 'UnLike' : 'Like',
          color: Theme.of(context).primaryColor,
          icon: pwd.favourite == 1 ? Icons.favorite : Icons.favorite_border,
          onTap: () {
            likeData(pwd);
            setState(() {});
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {
            deleteData(pwd.id);
          },
        ),
      ],
    );
  }
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
                print('edit');
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
                print('edit');
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
                print('edit');
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
                print('edit');
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
                print('edit');
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
            // const Text('Modal BottomSheet'),
            // RaisedButton(
            //   child: const Text('Close BottomSheet'),
            //   onPressed: () => Navigator.pop(context),
            // )
          ],
        ),
    );
  }
}
