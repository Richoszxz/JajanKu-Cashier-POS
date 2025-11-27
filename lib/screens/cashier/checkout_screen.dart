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
      (sum, item) => sum + (item.produk.hargaProduk * item.qty),
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

            // =============================================== //
            //            TAMPILAN ORDER DETAILS                //
            // =============================================== //
            Container(
              width: AppSize.lebar(context) * 1,
              height: AppSize.tinggi(context) * 0.25,
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
                  Text("Order Details", style: AppTextstyle.normalCoklat),
                  const SizedBox(height: 8),
                  Container(
                    width: AppSize.lebar(context) * 1,
                    height: AppSize.tinggi(context) * 0.18,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColor.warnaPrimer,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: widget.cartItems.map((item) {
                          return Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${item.produk.namaProduk}",
                                      style: AppTextstyle.namaProduk,
                                    ),
                                    Text(
                                      "Rp. ${item.produk.hargaProduk * item.qty}",
                                      style: AppTextstyle.normalCream,
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.network(
                                      item.produk.gambarProduk,
                                      width: 70,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.remove_circle_outline_rounded,
                                            size: 30,
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
                                            size: 30,
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
        height: AppSize.tinggi(context) * 0.08,
        decoration: BoxDecoration(
          color: AppColor.warnaSekunder,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(0, -8),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.warnaPrimer,
            ),
            child: Text(
              "Payment Confirmation",
              style: AppTextstyle.normalCream,
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
                  barrierColor: Colors.black54,
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
                        style: AppTextstyle.normalCream.copyWith(
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

  // BUAT PAYMENT DETAILS NGISI DETAILNYA

  Widget _row(List<String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data.map((e) => Expanded(child: Text(e))).toList(),
      ),
    );
  }

  Widget _rowTotalPayment(List<String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: data
            .map(
              (e) => Expanded(
                child: Text(e, style: GoogleFonts.poppins(fontSize: 20)),
              ),
            )
            .toList(),
      ),
    );
  }
}
