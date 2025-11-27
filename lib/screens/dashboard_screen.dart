import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/dashboardstatisticcard_widgets.dart';
import 'package:jajanku_pos/widgets/dashboardchartcard_widgets.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Data Transaksi Statis
  static const List<Map<String, String>> transactions = [
    {"no": "1", "code": "INV00005", "date": "10.09 21/10/2025"},
    {"no": "2", "code": "INV00004", "date": "09.58 21/10/2025"},
    {"no": "3", "code": "INV00003", "date": "09.50 21/10/2025"},
    {"no": "4", "code": "INV00002", "date": "09.30 21/10/2025"},
    {"no": "5", "code": "INV00001", "date": "09.27 21/10/2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.warnaLatar,
      appBar: AppbarWidget(judulHalaman: "Dashboard",),
      drawer: NavigationdrawerWidget(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Today's Sales Statistics
            _buildTodaySalesStats(),

            const SizedBox(height: 10),

            // 2. Total Stock & Customer Active
            Row(
              children: const <Widget>[
                DashboardstatisticcardWidgets(title: 'Total Stock', value: '60'),
                SizedBox(width: 10),
                DashboardstatisticcardWidgets(title: 'Customer Active', value: '54'),
              ],
            ),

            // 3. Weekly Sales Chart
            const DashboardchartcardWidgets(
              title: 'Weekly Sales Chart',
              chartType: ChartType.weekly,
            ),

            // 4. Monthly Sales Chart
            const DashboardchartcardWidgets(
              title: 'Monthly Sales Chart',
              chartType: ChartType.monthly,
            ),

            // 5. New Transaction List
            _buildNewTransactionList(),
          ],
        ),
      ),
    );
  }

  // --- Widget Functions ---

  Widget _buildTodaySalesStats() {
    return Card(
      color: AppColor.warnaPrimer,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Today's Sales Statistics",
              style: AppTextstyle.normalCream.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(color: Colors.white54, height: 20),
            _buildStatRow('Total Sales Today', 'Rp. 356.000'),
            _buildStatRow('Total Transaction', '36 Transaction'),
            _buildStatRow('Products Sold', '55 Item'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: AppTextstyle.normalCream.copyWith(fontSize: 16)),
          Text(
            value,
            style: AppTextstyle.smallBoldCream.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildNewTransactionList() {
    TextStyle headerStyle = GoogleFonts.poppins(
      color: AppColor.warnaSekunder,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    TextStyle dataStyle = GoogleFonts.poppins(color: AppColor.warnaSekunder);

    return Card(
      color: AppColor.warnaPrimer,
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'New Transaction List',
              style: AppTextstyle.normalCream.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          // Header Tabel
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: [
                Expanded(flex: 1, child: Text('No', style: headerStyle)),
                Expanded(
                  flex: 4,
                  child: Text('Transaction Code', style: headerStyle),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Date',
                    style: headerStyle,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: Colors.white54, height: 1),

          // Baris Data
          ...transactions.map((transaction) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(transaction['no']!, style: dataStyle),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction['code']!, style: dataStyle),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      transaction['date']!,
                      style: dataStyle,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
