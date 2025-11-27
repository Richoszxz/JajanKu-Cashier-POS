import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:google_fonts/google_fonts.dart';

enum ChartType { weekly, monthly }

class DashboardchartcardWidgets extends StatelessWidget {
  final String title;
  final ChartType chartType;
  const DashboardchartcardWidgets({
    super.key,
    required this.title,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.warnaPrimer, // Warna latar belakang kartu grafik
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: GoogleFonts.poppins(
                color: AppColor.warnaSekunder, // Warna teks Merah Maroon
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            // Menggunakan Expanded agar grafik mengisi ruang yang tersedia
            SizedBox(
              height: chartType == ChartType.weekly
                  ? 180
                  : 200, // Ketinggian berbeda
              child: BarChart(
                chartType == ChartType.weekly
                    ? _getWeeklyBarChartData()
                    : _getMonthlyBarChartData(),
                swapAnimationDuration: const Duration(milliseconds: 150),
                swapAnimationCurve: Curves.linear,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Data statis untuk Grafik Penjualan Mingguan
  BarChartData _getWeeklyBarChartData() {
    // Data dummy: nilai penjualan
    const List<double> weeklySales = [
      18,
      16,
      17,
      12,
      18,
      15,
      10,
    ]; // Nilai penjualan
    // Label hari
    const List<String> weekLabels = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 20,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  weekLabels[value.toInt()],
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                ),
              );
            },
            reservedSize: 30,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  weekLabels[value.toInt()],
                  style: const TextStyle(color: AppColor.warnaSekunder, fontSize: 10),
                ),
              );
            },
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}',
                style: const TextStyle(color: AppColor.warnaSekunder, fontSize: 10),
              );
            },
            reservedSize: 30,
          ),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: weeklySales.asMap().entries.map((entry) {
        int index = entry.key;
        double sales = entry.value;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: sales,
              color: AppColor.warnaSekunder, // Warna Merah Maroon
              width: 12,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // Data statis untuk Grafik Penjualan Bulanan
  BarChartData _getMonthlyBarChartData() {
    // Data dummy: nilai penjualan (Contoh: Total Penjualan & Target Penjualan)
    // Nilai bawah (penjualan) dan Nilai atas (Target/Total)
    const List<double> sales = [
      150,
      160,
      170,
      155,
      180,
      190,
      175,
      185,
      195,
      200,
      190,
      180,
    ];
    const List<double> total = [
      200,
      200,
      200,
      200,
      200,
      200,
      200,
      200,
      200,
      200,
      200,
      200,
    ];
    // Label bulan
    const List<String> monthLabels = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];

    return BarChartData(
      alignment: BarChartAlignment.spaceAround,
      maxY: 200,
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  monthLabels[value.toInt()],
                  style: const TextStyle(color: Colors.black, fontSize: 10),
                ),
              );
            },
            reservedSize: 30,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  monthLabels[value.toInt()],
                  style: TextStyle(color: AppColor.warnaSekunder, fontSize: 10),
                ),
              );
            },
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                '${value.toInt()}',
                style: TextStyle(color: AppColor.warnaSekunder, fontSize: 10),
              );
            },
            reservedSize: 30,
          ),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      barGroups: sales.asMap().entries.map((entry) {
        int index = entry.key;
        double salesValue = entry.value;
        double totalValue = total[index]; // Nilai total selalu 200

        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: totalValue, // Nilai atas (total/target)
              color: const Color(
                0xFFD3C4B6,
              ), // Warna krem muda untuk target/total
              width: 12,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  salesValue,
                  AppColor.warnaSekunder, // Warna Merah Maroon untuk penjualan
                ),

                BarChartRodStackItem(
                  salesValue,
                  totalValue,
                  AppColor.warnaPrimer.withOpacity(0.5),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }
}
