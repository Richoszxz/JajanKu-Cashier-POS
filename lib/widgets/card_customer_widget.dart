import 'package:flutter/material.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class CardCustomerWidget extends StatefulWidget {
  final Pelanggan pelanggan;

  const CardCustomerWidget({super.key, required this.pelanggan});

  @override
  State<CardCustomerWidget> createState() => _CardCustomerWidgetState();
}

class _CardCustomerWidgetState extends State<CardCustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.warnaPrimer,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(Icons.account_circle_outlined),
        ),
        title: Text(widget.pelanggan.kodePelanggan, style: AppTextstyle.appBarTeks,),
        subtitle: Text(widget.pelanggan.namaPelanggan, style: AppTextstyle.smallCream,),
        trailing: Icon(Icons.more_horiz),
      ),
    );
  }
}