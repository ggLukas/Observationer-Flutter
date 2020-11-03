import 'package:flutter/cupertino.dart';
import 'package:observationer/model/input_dialog.dart';

/// A Cupertino style dialog for iOS.
class iOSInputDialog implements InputDialog {
  Widget buildDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text('Lägg till ny observation'),
      content: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Image(
                width: 150,
                image: AssetImage('assets/images/Placeholder.png'),
              ),
              Text('Bifoga ny bild'),
            ],
          ),
          SizedBox(
            height: 32.0,
          ),
          CupertinoTextField(
            placeholder: 'Titel...',
          ),
          SizedBox(
            height: 32.0,
          ),
          CupertinoTextField(
            placeholder: 'Anteckningar...',
            maxLines: 3,
            maxLength: 250,
            keyboardType: TextInputType.multiline,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                  child: Text(
                    'Avbryt',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
              CupertinoButton(child: Text('Lägg till'), onPressed: () {})
            ],
          )
        ],
      ),
    ).build(context);
  }
}
