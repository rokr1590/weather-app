import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/utils/images.dart';

enum ToastType {
  error,
  warning,
  success,
  informative,
}

// Common toast msg show

showToast(
  String? msg,
  ToastType toastType,
  Size screenSize,
  BuildContext context, {
  FlushbarPosition? position,
}) {
  if (msg == null) return;
  Flushbar(
    // backgroundColor: CustomColor.bgLightGrey,
    backgroundColor: Colors.white,
    // title: toastType == ToastType.error
    //     ? 'Error'
    //     : toastType == ToastType.warning
    //         ? 'Warning'
    //         : toastType == ToastType.informative
    //             ? 'Info'
    //             : 'Success',
    // titleColor: toastType == ToastType.error
    //     ? CustomColor.toastErrorText
    //     : toastType == ToastType.warning
    //         ? CustomColor.toastWarningText
    //         : toastType == ToastType.informative
    //             ? CustomColor.toastInfoText
    //             : CustomColor.toastSuccessText,
    titleSize: screenSize.height * 0.018,
    titleText: Text(
      toastType == ToastType.error
          ? 'Error'
          : toastType == ToastType.warning
              ? 'Warning'
              : toastType == ToastType.informative
                  ? 'Info'
                  : 'Success',
      style: TextStyle(
        fontSize: screenSize.height * 0.018,
        color: toastType == ToastType.error
            ? CustomColor.toastErrorText
            : toastType == ToastType.warning
                ? CustomColor.toastWarningText
                : toastType == ToastType.informative
                    ? CustomColor.toastInfoText
                    : CustomColor.toastSuccessText,
        fontWeight: FontWeight.w500,
      ),
    ),
    message: msg,
    messageSize: screenSize.height * 0.016,
    boxShadows: [
      BoxShadow(
        color: CustomColor.grey,
        blurRadius: 7,
      )
    ],
    borderRadius: BorderRadius.circular(10),
    animationDuration: Duration(milliseconds: 300),
    duration: Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    messageColor: CustomColor.darkGrey,
    blockBackgroundInteraction: true,
    // isDismissible: false,
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    margin: EdgeInsets.only(
      left: 20,
      right: 20,
      bottom: 50,
    ),
    leftBarIndicatorColor: toastType == ToastType.error
        ? CustomColor.toastErrorText
        : toastType == ToastType.warning
            ? CustomColor.toastWarningText
            : toastType == ToastType.informative
                ? CustomColor.toastInfoText
                : CustomColor.toastSuccessText,
    icon: toastType == ToastType.error
        ? SvgPicture.asset(
            CustomIcon.toastErrorIcon,
            height: 30,
            color: CustomColor.toastErrorText,
          )
        : toastType == ToastType.warning
            ? SvgPicture.asset(
                CustomIcon.toastWarningIcon,
                height: screenSize.height * 0.030,
                color: CustomColor.toastWarningText,
              )
            : toastType == ToastType.informative
                ? SvgPicture.asset(
                    CustomIcon.toastInfoIcon,
                    height: screenSize.height * 0.030,
                    color: CustomColor.toastInfoText,
                  )
                : SvgPicture.asset(
                    CustomIcon.toastSuccessIcon,
                    height: screenSize.height * 0.030,
                    color: CustomColor.toastSuccessText,
                  ),
  ).show(context);
}