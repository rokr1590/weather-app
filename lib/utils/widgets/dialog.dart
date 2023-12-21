import 'package:flutter/material.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/globals.dart';

class ConfirmationDialog extends StatefulWidget {
  final Function() acceptAction;
  final Function() denyAction;
  final String header;
  final String content;
  final String acceptButtonText;
  final String denyButtonText;

  /// Decides which type of dialog should be shown
  /// (0: Confirmation dialog with green acceptAction, 1: Warning dialog with red acceptAction)
  final int dialogType;
  const ConfirmationDialog({
    Key? key,
    required this.acceptAction,
    required this.denyAction,
    required this.header,
    required this.content,
    required this.denyButtonText,
    required this.acceptButtonText,
    required this.dialogType,
  }) : super(key: key);

  @override
  State<ConfirmationDialog> createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {
  @override
  void dispose() {
    isShowingPopup = false;
    super.dispose();
  }

  late Size screenSize;
  @override
  Widget build(BuildContext context) {
    isShowingPopup = true;
    screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      titlePadding: EdgeInsets.only(
        top: screenSize.height * 0.04,
      ),
      title: Center(
        child: Text(
          '${widget.header}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      content: Container(
        width: screenSize.width,
        height: screenSize.height * 0.085,
        child: Center(
          child: Text(
            '${widget.content}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: CustomColor.fontDarkGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.only(
        bottom: screenSize.height * 0.02,
      ),
      actionsOverflowButtonSpacing: screenSize.height * 0.01,
      actions: [
        Visibility(
          visible: widget.denyButtonText.isNotEmpty,
          child: ElevatedButton(
            onPressed: widget.denyAction,
            child: Text(
              widget.denyButtonText,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: CustomColor.fontDarkGrey,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              elevation: 0,
              minimumSize: Size(
                screenSize.width * 0.25,
                screenSize.height * 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(
                  color: CustomColor.fontDarkGrey,
                ),
              ),
            ),
          ),
        ),
        // Spacer(),
        Visibility(
          visible: widget.denyButtonText.isNotEmpty,
          child: SizedBox(
            width: screenSize.width * 0.05,
          ),
        ),
        Visibility(
          visible: widget.acceptButtonText.isNotEmpty,
          child: ElevatedButton(
            onPressed: widget.acceptAction,
            child: Text(
              widget.acceptButtonText,
              style: TextStyle(
                fontSize: 18,
                color: widget.dialogType == 1 ? CustomColor.red : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: widget.dialogType == 1
                  ? Colors.transparent
                  : Colors.black,
              elevation: 0,
              minimumSize: Size(
                screenSize.width * 0.25,
                screenSize.height * 0.05,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: widget.dialogType == 1
                    ? BorderSide(
                        color: CustomColor.red,
                        width: 1,
                      )
                    : BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}