import 'package:flutter/material.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';

class ProfitlossReportScreen extends StatefulWidget {
  const ProfitlossReportScreen({super.key});

  @override
  State<ProfitlossReportScreen> createState() => _ProfitlossReportScreenState();
}

class _ProfitlossReportScreenState extends State<ProfitlossReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Profit & Loss Report"),
      drawer: const NavigationdrawerWidget(),
      body: const Center(
        child: Text('Profit & Loss Report Screen Content'),
      ),
    );
  }
}