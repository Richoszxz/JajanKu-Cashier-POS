import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Sales Report"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Sales Report Screen Content'),
      ),
    );
  }
}