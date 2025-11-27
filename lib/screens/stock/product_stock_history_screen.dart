import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/stockinoutlist_widgets.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/constants/app_size.dart';

class ProductStockHistoryScreen extends StatefulWidget {
  const ProductStockHistoryScreen({super.key});

  @override
  State<ProductStockHistoryScreen> createState() =>
      _ProductStockHistoryScreenState();
}

class _ProductStockHistoryScreenState extends State<ProductStockHistoryScreen> {
  final List<Map<String, dynamic>> dummyHistory = [
    {"product": "Risoles Mayo", "qty": 5, "type": "in"},
    {"product": "Risoles Mayo", "qty": 2, "type": "out"},
    {"product": "Risoles Sayur", "qty": 5, "type": "in"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Product Stock History"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  height: AppSize.tinggi(context) * 0.15,
                  width: AppSize.lebar(context) * 0.47,
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Stock In", style: AppTextstyle.normalCream),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.green,
                            size: 50,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "10",
                            style: AppTextstyle.normalCream.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(10),
                  height: AppSize.tinggi(context) * 0.15,
                  width: AppSize.lebar(context) * 0.47,
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Stock Out", style: AppTextstyle.normalCream),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.redAccent,
                            size: 50,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "2",
                            style: AppTextstyle.normalCream.copyWith(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            StockinoutlistWidgets(data: dummyHistory),
          ],
        ),
      ),
    );
  }
}
