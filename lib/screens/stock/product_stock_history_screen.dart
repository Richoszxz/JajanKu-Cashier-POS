import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class ProductStockHistoryScreen extends StatefulWidget {
  const ProductStockHistoryScreen({super.key});

  @override
  State<ProductStockHistoryScreen> createState() => _ProductStockHistoryScreenState();
}

class _ProductStockHistoryScreenState extends State<ProductStockHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Product Stock History"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Product Stock History Screen Content'),
      ),
    );
  }
}