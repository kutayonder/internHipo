import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hipoclientapp/models/hipomodel.dart';


class BlurryDialog extends StatelessWidget {

  List<HipoClient> userInfo;
  int index;

  BlurryDialog(this.userInfo,this.index);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child:  AlertDialog(
        title: Center(child: Text("${userInfo[index].name}")),
        content: Text("Age: ${userInfo[index].age}\nGithub: ${userInfo[index].github}\nLocation: ${userInfo[index].location}\nPosition: ${userInfo[index].hipo.position}\nYears in Hipo: ${userInfo[index].hipo.yearsInHipo}\n"), 
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ));
  }
}