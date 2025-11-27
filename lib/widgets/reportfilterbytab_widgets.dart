import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportfilterbytabWidgets extends StatefulWidget {
  final TabController controller;
  const ReportfilterbytabWidgets({super.key, required this.controller});

  @override
  State<ReportfilterbytabWidgets> createState() =>
      _ReportfilterbytabWidgetsState();
}

class _ReportfilterbytabWidgetsState extends State<ReportfilterbytabWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.tinggi(context) * 0.06,
      decoration: BoxDecoration(
        color: AppColor.warnaSekunder,
        border: Border.all(color: AppColor.warnaPrimer),
      ),
      child: TabBar(
        controller: widget.controller,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        unselectedLabelColor: AppColor.warnaPrimer,
        labelColor: AppColor.warnaSekunder,
        indicator: BoxDecoration(
          color: AppColor.warnaPrimer,
        ),
        tabs: [
          Tab(
            child: Text(
              "Product",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
          Tab(
            child: Text(
              "Customer",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
