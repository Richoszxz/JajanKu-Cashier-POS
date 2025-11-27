import 'package:flutter/material.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class DetailCustomerScreen extends StatefulWidget {
  final Pelanggan pelanggan;

  const DetailCustomerScreen({super.key, required this.pelanggan});

  @override
  State<DetailCustomerScreen> createState() => _DetailCustomerScreenState();
}

class _DetailCustomerScreenState extends State<DetailCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        judulHalaman: "Customer Detail",
        tombolKembali: true,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(10),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundColor: AppColor.warnaPrimer,
                        child: Icon(
                          Icons.account_circle_outlined,
                          size: 150,
                          color: AppColor.warnaSekunder,
                        ),
                      ),
                    ],
                  ),
                ),

                // BASE INFORMATION
                Container(
                  height: AppSize.tinggi(context) * 0.20,
                  width: AppSize.lebar(context) * 1,
                  margin: EdgeInsets.only(bottom: 13),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.warnaSekunder,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Base Information",
                        style: AppTextstyle.normalCoklat,
                      ),
                      Container(
                        height: AppSize.tinggi(context) * 0.14,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.warnaPrimer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Customer Code",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Username",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Registration Date",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    widget.pelanggan.kodePelanggan,
                                    style: AppTextstyle.smallCream,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    widget.pelanggan.namaPelanggan,
                                    style: AppTextstyle.smallCream,
                                    maxLines: 1,
                                  ),
                                  Text(
                                    widget.pelanggan.tanggalRegistrasi.toString().split(" ").first,
                                    style: AppTextstyle.smallCream,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // CUSTOMER CONTACT
                Container(
                  height: AppSize.tinggi(context) * 0.20,
                  width: AppSize.lebar(context) * 1,
                  margin: EdgeInsets.only(bottom: 13),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.warnaSekunder,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customer Contact",
                        style: AppTextstyle.normalCoklat,
                      ),
                      Container(
                        height: AppSize.tinggi(context) * 0.14,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.warnaPrimer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Email",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Address",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.pelanggan.nomoHandphonePelanggan,
                                  style: AppTextstyle.smallCream,
                                ),
                                Text(
                                  widget.pelanggan.emailPelanggan,
                                  style: AppTextstyle.smallCream,
                                ),
                                Text(
                                  "-",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ACTIVITES AND TRANSACTIONS
                Container(
                  height: AppSize.tinggi(context) * 0.20,
                  width: AppSize.lebar(context) * 1,
                  margin: EdgeInsets.only(bottom: 13),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.warnaSekunder,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 8),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activites and Transactions",
                        style: AppTextstyle.normalCoklat,
                      ),
                      Container(
                        height: AppSize.tinggi(context) * 0.14,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.warnaPrimer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Transactions",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Total Spending",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  "Last Transaction",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.pelanggan.totalTransaksiPelanggan.toString(),
                                  style: AppTextstyle.smallCream,
                                ),
                                Text(
                                  "-",
                                  style: AppTextstyle.smallBoldCream,
                                ),
                                Text(
                                  widget.pelanggan.terakhirTransaksi.toString().split(" ").first,
                                  style: AppTextstyle.smallCream,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
