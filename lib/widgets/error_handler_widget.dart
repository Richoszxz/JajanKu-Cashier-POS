import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:jajanku_pos/constants/app_color.dart';

void successAlert(
  BuildContext context, {
  required String text,
  required String title,
}) {
  QuickAlert.show(
    context: context,
    barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
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
    barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
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
  Function()? onConfirm,
}) {
  QuickAlert.show(
    context: context,
    barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
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
      if (onConfirm != null) {
        await onConfirm(); // jalankan aksi custom
      }
    },
  );
}
