import 'package:flutter/material.dart';
import 'package:subtrack/widgets/custom_text_button.dart';
import 'package:subtrack/widgets/text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String btnText;
  final VoidCallback onPressed;
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.btnText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      alignment: Alignment.center,
      contentPadding: EdgeInsets.only(left: 26, right: 4, top: 14),
      actionsPadding: EdgeInsets.only(left: 18, right: 18, bottom: 20, top: 0),
      backgroundColor: colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colorScheme.surfaceContainerLowest),
      ),
      title: BuildText(text: title, textSize: 16, textWeight: FontWeight.w600),
      content: BuildText(text: content, textSize: 13),
      actions: [
        CustomTextButton(
          buttonStyle: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          text: "Go Back",
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        CustomTextButton(
          buttonStyle: TextButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: colorScheme.surfaceContainerLow),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          text: btnText,
          onPressed: onPressed,
        ),
      ],
    );
  }
}
