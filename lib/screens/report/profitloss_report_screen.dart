import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/reporttabbar_widgets.dart';
import 'package:jajanku_pos/constants/app_color.dart';

class ProfitlossReportScreen extends StatefulWidget {
  const ProfitlossReportScreen({super.key});

  @override
  State<ProfitlossReportScreen> createState() => _ProfitlossReportScreenState();
}

class _ProfitlossReportScreenState extends State<ProfitlossReportScreen>
    with TickerProviderStateMixin {
  late TabController timeTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timeTabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Profit & Loss Report"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReporttabbarWidgets(controller: timeTabController),
            SizedBox(height: 10),
            SizedBox(
              height: AppSize.tinggi(context) * 0.23,
              child: TabBarView(
                controller: timeTabController,
                children: [_dailyTable(), _weeklyTable(), _monthlyTable()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dailyTable() {
    return _tableContainer(
      children: [
        _tableHeader(["Description", "Nominal"]),
        Divider(color: Colors.white54, height: 20),
        _tableRow(["Total Sales", "Rp. 300.000"]),
        _tableRow(["Total Discounts", "-Rp. 15.000"]),
        _rowNetProfit(["Net Profit On Sales", "Rp. 285.000"]),
      ],
    );
  }

  Widget _weeklyTable() {
    return _tableContainer(
      children: [
        _tableHeader(["Description", "Nominal"]),
        Divider(color: Colors.white54, height: 20),
        _tableRow(["Total Sales", "Rp. 300.000"]),
        _tableRow(["Total Discounts", "-Rp. 15.000"]),
        _rowNetProfit(["Net Profit On Sales", "Rp. 285.000"]),
      ],
    );
  }

  Widget _monthlyTable() {
    return _tableContainer(
      children: [
        _tableHeader(["Description", "Nominal"]),
        Divider(color: Colors.white54, height: 20),
        _tableRow(["Total Sales", "Rp. 300.000"]),
        _tableRow(["Total Discounts", "-Rp. 15.000"]),
        _rowNetProfit(["Net Profit On Sales", "Rp. 285.000"]),
      ],
    );
  }

  // TABEL WIDGETS COMPONENT

  Widget _tableContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _tableHeader(List<String> headers) {
    return Row(
      children: headers
          .map(
            (e) => Expanded(child: Text(e, style: AppTextstyle.smallBoldCream)),
          )
          .toList(),
    );
  }

  Widget _tableRow(List<String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: data
            .map(
              (e) => Expanded(
                child: Text(
                  e,
                  style: AppTextstyle.smallCream.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _rowNetProfit(List<String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: data
            .map(
              (e) => Expanded(
                child: Text(
                  e,
                  style: AppTextstyle.normalCream.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
