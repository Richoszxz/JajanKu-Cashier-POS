import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class StockProductScreen extends StatefulWidget {
  const StockProductScreen({super.key});

  @override
  State<StockProductScreen> createState() => _StockProductScreenState();
}

class _StockProductScreenState extends State<StockProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Stock Product"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Stock Product Screen Content'),
      ),
    );
  }
}