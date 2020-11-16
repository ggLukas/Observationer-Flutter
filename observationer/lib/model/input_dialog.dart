import 'package:flutter/cupertino.dart';

/// Interface for input dialogs.
abstract class InputDialog {
  Function onPressPositive;
  Function onPressNegative;

  Widget buildDialog(BuildContext context);
}
