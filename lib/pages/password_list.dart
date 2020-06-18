import 'package:flutter/material.dart';
import 'package:flutter_password/components/custom_icon.dart';
import 'package:flutter_password/models/password.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_password/dao/passwordDao.dart';
import 'package:flutter_password/components/list_view.dart';

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


