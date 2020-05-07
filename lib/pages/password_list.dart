import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';
import 'package:flutter_password/models/password.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_password/dao/passwordDao.dart';
import 'package:bot_toast/bot_toast.dart';

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
    BotToast.showSimpleNotification(title: '当前点击按钮：$action');
  }

  void getData() async {
    PasswordDao pwdDao = new PasswordDao();

    List<PasswordModel> ret = await pwdDao.findAll();
    setState(() {
      pwdList = ret;
    });
  }

  // @override
  Widget build(BuildContext context) {
    if (pwdList == null) {
      return new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
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
          caption: 'Like',
          color: Theme.of(context).primaryColor,
          icon: Icons.favorite_border,
          onTap: () => _showSnackBar('Like'),
        ),
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {
            _showSnackBar('Delete');
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
      child: Container(
        color: Colors.white,
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
              new Text(
                pwd.password,
                style: new TextStyle(color: Colors.grey, fontSize: 14.0),
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
        // child: ListTile(
        // 	leading: CircleAvatar(
        // 		backgroundColor: Colors.indigoAccent,
        // 		child: Text('A'),
        // 		foregroundColor: Colors.white,
        // 	),
        // 	title: Text(pwd.name),
        // 	subtitle: Text('SlidableDrawerDelegate'),
        // ),
      ),
    );
  }
}
