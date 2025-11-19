import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class CashierPosScreen extends StatefulWidget {
  const CashierPosScreen({super.key});

  @override
  State<CashierPosScreen> createState() => _CashierPosScreenState();
}

class _CashierPosScreenState extends State<CashierPosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Cashier POS"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Cashier POS Screen Content'),
      ),
    );
  }
}