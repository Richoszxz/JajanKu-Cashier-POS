import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/reporttabbar_widgets.dart';
import 'package:jajanku_pos/widgets/reportfilterbytab_widgets.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/constants/app_size.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen>
    with TickerProviderStateMixin {
  late TabController timeTabController;
  late TabController filterTabController;

  @override
  void initState() {
    super.initState();
    timeTabController = TabController(length: 3, vsync: this);
    filterTabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Sales Report"),
      drawer: const NavigationdrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TIME TAB (Daily, Weekly, Monthly)
            ReporttabbarWidgets(controller: timeTabController),
            const SizedBox(height: 10),

            Text("Filtered by:", style: GoogleFonts.poppins()),
            const SizedBox(height: 10),

            /// FILTER TAB (Product / Customer)
            ReportfilterbytabWidgets(controller: filterTabController),
            const SizedBox(height: 10),

            /// PRINT PDF - EXPORT BUTTONS (NO WIDGET)
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: AppSize.tinggi(context) * 0.05,
                    width: AppSize.lebar(context) * 0.40,
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.warnaPrimer, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_as_pdf_outlined,
                          color: AppColor.warnaTeks,
                        ),
                        const SizedBox(width: 5),
                        Text("Print Out PDF", style: AppTextstyle.smallCoklat),
                      ],
                    ),
                  ),
                  Container(
                    height: AppSize.tinggi(context) * 0.05,
                    width: AppSize.lebar(context) * 0.40,
                    decoration: BoxDecoration(
                      color: AppColor.warnaSekunder,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColor.warnaPrimer, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.download_outlined,
                          color: AppColor.warnaTeks,
                        ),
                        const SizedBox(width: 5),
                        Text("Export", style: AppTextstyle.smallCoklat),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// CONTENT (AUTOMATIC SWITCH BASED ON TAB)
            Expanded(
              child: TabBarView(
                controller: filterTabController,
                children: [_productReport(), _customerReport()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PRODUCT REPORT VIEW
  // ============================================================

  Widget _productReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _totalSales(),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _boxInfo(
                  title: "Top Product",
                  subtitle: "Risoles Mayo x40",
                  value: "Rp. 100.000",
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: _boxInfo(
                  title: "Lowest Product",
                  subtitle: "Risoles Sayur x20",
                  value: "Rp. 40.000",
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _boxInfo(
                  title: "Top Order",
                  subtitle: "",
                  value: "Rp. 56.000",
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: _boxInfo(
                  title: "Lowest Order",
                  subtitle: "",
                  value: "Rp. 2.500",
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          _productTable(),
        ],
      ),
    );
  }

  // ============================================================
  // CUSTOMER REPORT VIEW
  // ============================================================

  Widget _customerReport() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _totalSales(),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _boxInfo(
                  title: "Top Product",
                  subtitle: "Risoles Mayo x40",
                  value: "Rp. 100.000",
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: _boxInfo(
                  title: "Lowest Product",
                  subtitle: "Risoles Sayur x20",
                  value: "Rp. 40.000",
                ),
              ),
            ],
          ),

          SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: _boxInfo(
                  title: "Top Order",
                  subtitle: "",
                  value: "Rp. 56.000",
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: _boxInfo(
                  title: "Lowest Order",
                  subtitle: "",
                  value: "Rp. 2.500",
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),
          _customerTable(),
        ],
      ),
    );
  }

  // ============================================================
  // COMPONENTS
  // ============================================================

  Widget _totalSales() {
    return Container(
      width: AppSize.lebar(context) * 1,
      height: AppSize.tinggi(context) * 0.17,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Total Sales",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(
            "Rp. 236.000",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxInfo({
    required String title,
    required String subtitle,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      width: AppSize.lebar(context) * 0.50,
      height: AppSize.tinggi(context) * 0.15,
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: GoogleFonts.poppins(color: Colors.white)),
          const SizedBox(height: 5),
          if (subtitle.isNotEmpty)
            Text(
              subtitle,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TABLE PRODUCT
  // ============================================================

  Widget _productTable() {
    return _tableContainer(
      children: [
        _tableHeader(["Product", "Qty Sold", "Total Sales"]),
        Divider(color: Colors.white54, height: 20),
        _tableRow(["Risoles Mayo", "60", "Rp. 150.000"]),
        _tableRow(["Risoles Mentai", "45", "Rp. 157.500"]),
        _tableRow(["Risoles Sayur", "35", "Rp. 70.000"]),
      ],
    );
  }

  // ============================================================
  // TABLE CUSTOMER
  // ============================================================

  Widget _customerTable() {
    return _tableContainer(
      children: [
        _tableHeader(["Customer", "Total Order", "Total Spending"]),
        Divider(color: Colors.white54, height: 20),
        _tableRow(["Richu", "10x", "Rp. 76.000"]),
        _tableRow(["Riche", "7x", "Rp. 53.000"]),
        _tableRow(["Richa", "4x", "Rp. 35.000"]),
        _tableRow(["Richa", "3x", "Rp. 30.000"]),
      ],
    );
  }

  // ============================================================
  // TABLE COMPONENTS
  // ============================================================

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
          .map((e) => Expanded(child: Text(e, style: AppTextstyle.smallBoldCream)))
          .toList(),
    );
  }

  Widget _tableRow(List<String> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: data
            .map(
              (e) => Expanded(child: Text(e, style: AppTextstyle.smallCream)),
            )
            .toList(),
      ),
    );
  }
}
