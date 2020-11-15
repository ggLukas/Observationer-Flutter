import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDialog {
  //if dismissible is false, you can not dismiss the dialog by pressing on the background
  void buildDialog(BuildContext context, String title, String description, bool dismissible) {
    //IOS MESSAGE DIALOG
    if(Platform.isIOS) {
      buildIOSDialog(context, title, description, dismissible);
    }
    //ANDROID MESSAGE DIALOG
    else {
      buildAndroidDialog(context, title, description, dismissible);
    }
  }

  void buildAndroidDialog(BuildContext context, String title, String description, bool dismissible){
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void buildIOSDialog(BuildContext context, String title, String description, bool dismissible){
    showDialog(
        context: context,
        barrierDismissible: dismissible,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description),
                ],
              ),
            ),
            actions: <Widget>[
              CupertinoButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

}
