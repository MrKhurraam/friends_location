import 'package:flutter/material.dart';

class ShowDialog {
  static Future<void> showErrorDialog({title, description, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "${title}",
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${description}",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Okay"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showLoadingDialog({title, description, context}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "${title}",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
