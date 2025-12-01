import 'package:flutter/material.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/screens/customer/detail_customer_screen.dart';
import 'package:jajanku_pos/screens/customer/edit_customer_screen.dart';

class CardCustomerWidget extends StatefulWidget {
  final Pelanggan pelanggan;

  const CardCustomerWidget({super.key, required this.pelanggan});

  @override
  State<CardCustomerWidget> createState() => _CardCustomerWidgetState();
}

class _CardCustomerWidgetState extends State<CardCustomerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Center(
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.warnaSekunder,
            ),
            child: Icon(Icons.account_circle_outlined, size: 45, color: AppColor.warnaTeks),
          ),
          title: Text(
            widget.pelanggan.kodePelanggan.toString(),
            style: AppTextstyle.normalCream,
          ),
          subtitle: Text(
            widget.pelanggan.namaPelanggan,
            style: AppTextstyle.appBarTeks,
            maxLines: 1,
          ),
          trailing: PopupMenuButton<String>(
            color: AppColor.warnaSekunder, // Warna background menu
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bentuk menu
            ),
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.warnaSekunder, // Background untuk icon 3 titik
              ),
              child: Icon(Icons.more_horiz, color: AppColor.warnaPrimer),
            ),
            onSelected: (String result) {
              // Logika navigasi berdasarkan item yang dipilih
              switch (result) {
                case 'details':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailCustomerScreen(pelanggan: widget.pelanggan),
                    ),
                  );
                  break;
                case 'edit':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditCustomerScreen(pelanggan: widget.pelanggan),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              // Item menu untuk "Details"
              PopupMenuItem<String>(
                value: 'details',
                child: Row(
                  children: [
                    Icon(Icons.list_alt, color: AppColor.warnaPrimer),
                    const SizedBox(width: 8),
                    Text(
                      'Details',
                      style: AppTextstyle.smallCoklat,
                    ),
                  ],
                ),
              ),
              // Item menu untuk "Edit"
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: AppColor.warnaPrimer),
                    const SizedBox(width: 8),
                    Text(
                      'Edit',
                      style: AppTextstyle.smallCoklat,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
