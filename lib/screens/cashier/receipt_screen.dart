import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/screens/cashier/cashier_pos_screen.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';

class ReceiptScreen extends StatefulWidget {
  final String transactionCode;
  final String date;
  final String customer;
  final String cashier;
  final int subtotal;
  final int discount;
  final int total;
  final int cash;
  final int change;
  final List<CartItem> items;
  const ReceiptScreen({
    super.key,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.transactionCode,
    required this.date,
    required this.customer,
    required this.cashier,
    required this.cash,
    required this.change,
    required this.items,
  });

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Receipt", tombolKembali: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // CARD UTAMA
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: AppColor.warnaPrimer, width: 3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // LOGO
                  Image.asset(
                    'assets/images/imagesplashscreen.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                  ),

                  // INFORMASI TRANSAKSI
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        rowInfo("Transaction Code", widget.transactionCode),
                        rowInfo("Date", widget.date),
                        rowInfo("Customer", widget.customer),
                        rowInfo("Cashier", widget.cashier),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ITEM
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...widget.items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.produk.namaProduk,
                                  style: AppTextstyle.namaProduk.copyWith(
                                    color: AppColor.warnaTeks,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${item.qty} x Rp. ${item.produk.hargaProduk}",
                                      style: AppTextstyle.smallCoklat,
                                    ),
                                    Text(
                                      "Rp. ${item.qty * item.produk.hargaProduk}",
                                      style: AppTextstyle.smallCoklat,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // PAYMENT DETAILS
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Method",
                              style: AppTextstyle.smallCoklat,
                            ),

                            Text("Cash", style: AppTextstyle.smallCoklat),
                          ],
                        ),
                        Divider(thickness: 1, color: AppColor.warnaPrimer),
                        rowInfo("Subtotal", "Rp. ${widget.subtotal}"),
                        rowInfo("Discounts", "-Rp. ${widget.discount}"),
                        rowInfo("Total", "Rp. ${widget.total}"),
                        rowInfo("Cash", "Rp. ${widget.cash}"),
                        rowInfo("Change", "Rp. ${widget.change}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // BUTTON PRINT
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.warnaPrimer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Print Out Receipt",
                  style: AppTextstyle.normalCream,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // BUTTON BACK
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.warnaPrimer,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Back",
                  style: AppTextstyle.normalCream,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              "CV. Richo Berkah Jaya Imup, Tbk.",
              style: GoogleFonts.poppins(
                color: AppColor.warnaNamaPerusahaan,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget rowInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextstyle.smallCoklat),
          Text(value, style: AppTextstyle.smallCoklat),
        ],
      ),
    );
  }
}
