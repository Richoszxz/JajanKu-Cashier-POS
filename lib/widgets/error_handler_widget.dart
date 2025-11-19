import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/routes/app_routes.dart';
import 'package:jajanku_pos/services/authentication_services.dart';

void successAlert(
  BuildContext context, {
  required String text,
  required String title,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: title,
    titleColor: AppColor.warnaTeks,
    text: text,
    textColor: AppColor.warnaTeks,
    backgroundColor: AppColor.warnaSekunder,
    showConfirmBtn: false,
    autoCloseDuration: Duration(seconds: 2),
  );
}

void errorAlert(
  BuildContext context, {
  required String text,
  required String title,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: title,
    titleColor: AppColor.warnaTeks,
    text: text,
    textColor: AppColor.warnaTeks,
    backgroundColor: AppColor.warnaSekunder,
    showConfirmBtn: false,
    autoCloseDuration: Duration(seconds: 2),
  );
}

void confirmAlert(
  BuildContext context, {
  required String text,
  required String title,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.confirm,
    title: title,
    titleColor: AppColor.warnaTeks,
    text: text,
    textColor: AppColor.warnaTeks,
    backgroundColor: AppColor.warnaSekunder,
    confirmBtnText: 'Ok',
    confirmBtnColor: AppColor.warnaPrimer,
    cancelBtnTextStyle: TextStyle(color: AppColor.warnaTeks),
    onConfirmBtnTap: () async {
      try {
        await AuthenticationServices().signOut();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginScreen,
            (route) => false,
          );
          successAlert(
            context,
            text: "Successed to sign out!",
            title: "Success!",
          );
        }
      } catch (e) {
        Navigator.pop(context);
        errorAlert(
          context,
          text: "Request sign out error!",
          title: "Oops . . .",
        );
      }
    },
  );
}
