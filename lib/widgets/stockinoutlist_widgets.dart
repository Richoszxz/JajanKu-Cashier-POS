import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class StockinoutlistWidgets extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const StockinoutlistWidgets({super.key, required this.data});

  Color getTypeColor(String type) {
    if (type == "in") return Color(0xFF4CAF50);
    if (type == "out") return Color(0xFFFF7043);
    return Colors.grey;
  }

  String getTypeLabel(String type) {
    if (type == "in") return "Stock In";
    if (type == "out") return "Stock Out";
    return "-";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          return Container(
            margin: EdgeInsets.only(bottom: 10),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColor.warnaPrimer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama Produk
                Text(
                  item["product"],
                  style: AppTextstyle.namaProduk.copyWith(fontSize: 20),
                ),
                SizedBox(height: 6),

                // Quantity
                Text(
                  "Quantity: ${item["qty"]}",
                  style: AppTextstyle.smallCream,
                ),
                SizedBox(height: 4),

                // Type (badge)
                Row(
                  children: [
                    Text("Type: ", style: AppTextstyle.smallCream),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: getTypeColor(item["type"]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        getTypeLabel(item["type"]),
                        style: AppTextstyle.smallCoklat.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
