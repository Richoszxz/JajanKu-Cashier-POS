import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/searchbar_widgets.dart';
import 'package:jajanku_pos/widgets/stockproductlist_widgets.dart';

class StockProductScreen extends StatefulWidget {
  const StockProductScreen({super.key});

  @override
  State<StockProductScreen> createState() => _StockProductScreenState();
}

class _StockProductScreenState extends State<StockProductScreen> {
  final TextEditingController namaProdukController = TextEditingController();
  final TextEditingController stokprodukController = TextEditingController();
  final TextEditingController tambahStokProdukController =
      TextEditingController();

  final List<Map<String, dynamic>> dummyProducts = [
    {"name": "Risoles Mayo", "price": 2500, "stock": 15, "status": "secure"},
    {
      "name": "Risoles Sayur",
      "price": 2000,
      "stock": 0,
      "status": "out_of_stock",
    },
    {
      "name": "Risoles Mentai",
      "price": 3500,
      "stock": 3,
      "status": "below_minimum",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Stock Product"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 10),
                Text("Out of stock is", style: AppTextstyle.smallCoklat),
                SizedBox(width: 5),
                Text(
                  "marked in red",
                  style: GoogleFonts.poppins(color: Color(0xFFFF7043)),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(width: 10),
                Text(
                  "Stock below the minimum is",
                  style: AppTextstyle.smallCoklat,
                ),
                SizedBox(width: 5),
                Text(
                  "marked in yellow",
                  style: GoogleFonts.poppins(color: Color(0xFFFFD54F)),
                ),
              ],
            ),
            SizedBox(height: 10),
            SearchbarWidgets(hintText: "Search product . . ."),
            StockProductListWidget(products: dummyProducts),
          ],
        ),
      ),
    );
  }
}
