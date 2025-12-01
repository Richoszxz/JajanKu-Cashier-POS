import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/screens/cashier/cashier_pos_screen.dart';
import 'package:jajanku_pos/widgets/custom_autocomplete_customer_widgets.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/widgets/discounts_dialog_widgets.dart';
import 'package:jajanku_pos/widgets/payment_method_bottom_sheet_widgets.dart';
import 'package:jajanku_pos/widgets/textformfield_widget.dart';
import 'package:jajanku_pos/screens/cashier/receipt_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const CheckoutScreen({super.key, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Pelanggan? selectedCustomer;
  final TextEditingController cashPaidController = TextEditingController();

  int get subtotal {
    return widget.cartItems.fold(
      0,
      (sum, item) => sum + (item.produk.hargaProduk.toInt() * item.qty),
    );
  }

  void showPaymentConfirmationDialog() {
    final int cashPaid = int.tryParse(cashPaidController.text) ?? 0;
    final int totalPayment = subtotal - 1500; // DISKON SEMENTARA CONTOH
    final int change = cashPaid - totalPayment;

    showDialog(
      context: context,
      barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.warnaSekunder,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColor.warnaPrimer, width: 6),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment Confirmation",
                      style: AppTextstyle.normalCoklat,
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close_rounded, size: 28),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Customer", style: AppTextstyle.smallCoklat),
                    Text(
                      selectedCustomer?.namaPelanggan ?? "No Customer",
                      style: AppTextstyle.smallCoklat,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Payment Method", style: AppTextstyle.smallCoklat),
                    Text("Cash", style: AppTextstyle.smallCoklat),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Cash Paid", style: AppTextstyle.smallCoklat),
                    Text("Rp. $cashPaid", style: AppTextstyle.smallCoklat),
                  ],
                ),

                Divider(color: AppColor.warnaPrimer, height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total", style: AppTextstyle.normalCoklat),
                    Text("Rp. $totalPayment", style: AppTextstyle.normalCoklat),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // CANCEL BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(
                              color: AppColor.warnaPrimer,
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.warnaPrimer,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // CONFIRM BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);

                            // NAVIGATE KE RECEIPT
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReceiptScreen(
                                  subtotal: subtotal,
                                  discount: 1500,
                                  total: totalPayment,
                                  cash: cashPaid,
                                  change: change,
                                  customer:
                                      selectedCustomer?.namaPelanggan ?? "-",
                                  transactionCode: "INV000001",
                                  date: DateTime.now().toString(),
                                  cashier: "Richo",
                                  items: widget.cartItems,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.warnaPrimer,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Confirm",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Check Out", tombolKembali: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAutocompleteCustomerWidget(
              label: "Customer",
              value: selectedCustomer,
              onSelected: (value) {
                setState(() {
                  selectedCustomer = value;
                });
              },
            ),
            const SizedBox(height: 10),

            // ================================
            //        TAMPILAN ORDER DETAILS
            // ================================
            Container(
              width: AppSize.lebar(context),
              margin: const EdgeInsets.only(bottom: 13),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.warnaSekunder,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Order details", style: AppTextstyle.normalCoklat),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.warnaSekunder,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColor.warnaPrimer,
                            width: 3,
                          ),
                        ),
                        child: Text("Add", style: AppTextstyle.normalCoklat),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // ===== LIST ITEM =====
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColor.warnaPrimer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: widget.cartItems.map((item) {
                        return Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // ============================
                              //     KOLOM KIRI (NAME + PRICE)
                              // ============================
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.produk.namaProduk,
                                      style: AppTextstyle.namaProduk.copyWith(fontSize: 20),
                                    ),
                                    SizedBox(height: 75),
                                    Text(
                                      "Rp. ${item.produk.hargaProduk * item.qty}",
                                      style: AppTextstyle.normalCream,
                                    ),
                                  ],
                                ),
                              ),

                              // ============================
                              //    KOLOM KANAN (IMAGE + QTY)
                              // ============================
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // GAMBAR (kanan atas)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.produk.gambarProduk.toString(),
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  const SizedBox(height: 30),

                                  // COUNTER (kanan bawah)
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.remove_circle_outline_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${item.qty}",
                                        style: AppTextstyle.normalCream,
                                      ),
                                      IconButton(
                                        onPressed: null,
                                        icon: Icon(
                                          Icons.add_circle_rounded,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // PAYMENT METHOD
            _buildField(
              "Payment Methods",
              "Select Payment Method",
              Icon(Icons.payment_rounded),
            ),

            // Discounts
            _buildField(
              "Discounts",
              "Select Voucher Discounts",
              Icon(Icons.discount_rounded),
            ),

            // Payment Details
            Container(
              width: AppSize.lebar(context) * 1,
              height: AppSize.tinggi(context) * 0.22,
              margin: const EdgeInsets.only(bottom: 13),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColor.warnaSekunder,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(0, 8),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Payment Details", style: AppTextstyle.normalCoklat),
                  const SizedBox(height: 8),
                  Container(
                    width: AppSize.lebar(context) * 1,
                    height: AppSize.tinggi(context) * 0.15,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.warnaPrimer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Subtotal",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaSekunder,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Rp. 6.000",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaSekunder,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Discounts",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaSekunder,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "-Rp. 1.500",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaTeks,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Payment",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaSekunder,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "Rp. 4.500",
                                style: GoogleFonts.poppins(
                                  color: AppColor.warnaSekunder,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Cash paid
            TextformfieldWidget(
              label: "Cash Paid",
              hintText: "Input cash paided . . .",
              controller: cashPaidController,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: AppSize.tinggi(context) * 0.10,
        decoration: BoxDecoration(
          color: AppColor.warnaSekunder,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.warnaSekunder.withOpacity(0.5),
              offset: const Offset(0, -8),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                showPaymentConfirmationDialog();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.warnaPrimer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Payment Confirmation",
                style: AppTextstyle.normalCream,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String labelInfo, Icon icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.warnaSekunder,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(0, 8),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextstyle.normalCoklat),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              if (label == "Payment Methods") {
                showModalBottomSheet(
                  context: context,
                  barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
                  builder: (_) => PaymentMethodBottomSheetWidgets(
                    onSelected: (value) {
                      print("payment selected $value");
                    },
                  ),
                );
              }

              if (label == "Discounts") {
                showDialog(
                  context: context,
                  barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
                  builder: (_) => DiscountsDialogWidgets(
                    onSelected: (value) {
                      print("Discount Selected: $value");
                    },
                  ),
                );
              }
            },
            child: Container(
              height: AppSize.tinggi(context) * 0.07,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.warnaPrimer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: AppColor.warnaSekunder,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: icon,
                      ),
                      SizedBox(width: 10),
                      Text(
                        labelInfo,
                        style: AppTextstyle.smallCream.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: AppColor.warnaSekunder,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.arrow_forward_ios, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
