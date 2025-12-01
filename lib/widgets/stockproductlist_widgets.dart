import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class StockProductListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const StockProductListWidget({super.key, required this.products});

  Color getStatusColor(String status) {
    switch (status) {
      case "secure":
        return Color(0xFF4CAF50);
      case "below_minimum":
        return Color(0xFFFFD54F);
      case "out_of_stock":
        return Color(0xFFFF7043);
      default:
        return Colors.grey;
    }
  }

  String getStatusLabel(String status) {
    switch (status) {
      case "secure":
        return "Secure";
      case "below_minimum":
        return "Below Minimum";
      case "out_of_stock":
        return "Out Of Stock";
      default:
        return "";
    }
  }

  void _showEditStockDialog(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
    showDialog(
      context: context,
      barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
      builder: (context) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColor.warnaSekunder,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColor.warnaPrimer,
                width: 6,
              ), // border merah tebal
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Edit Stock",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color:  AppColor.warnaTeks,
                  ),
                ),
                const SizedBox(height: 25),

                // Product Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Product Name",
                    style: AppTextstyle.normalCoklat,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    product["name"],
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Stock (current)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stock",
                    style: AppTextstyle.normalCoklat
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    product["stock"].toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // Garis pemisah
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: 1,
                  color: AppColor.warnaPrimer
                ),

                // New Stock Input
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "New Stock Input",
                    style: AppTextstyle.normalCoklat
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColor.warnaPrimer,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    hintText: "0",
                    hintStyle: TextStyle(color: AppColor.warnaSekunder),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Tombol Cancel & Save
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
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
                    const SizedBox(width: 15),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () =>
                              Navigator.pop(context), // cuma nutup dialog
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.warnaPrimer,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            "Save",
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          final statusColor = getStatusColor(p["status"]);
          final statusLabel = getStatusLabel(p["status"]);

          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.warnaPrimer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p["name"],
                      style: AppTextstyle.namaProduk.copyWith(fontSize: 22),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Price: Rp. ${p["price"]}",
                      style: AppTextstyle.smallCream,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Stock: ${p["stock"]}",
                      style: AppTextstyle.smallCream,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("Status: ", style: AppTextstyle.smallCream),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            statusLabel,
                            style: AppTextstyle.smallCoklat.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColor.warnaSekunder,
                  ),
                  child: IconButton(
                    onPressed: () => _showEditStockDialog(context, p),
                    icon: Icon(Icons.edit, color: AppColor.warnaTeks),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
