import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_size.dart';

class ReporttabbarWidgets extends StatefulWidget {
  final TabController controller;
  const ReporttabbarWidgets({super.key, required this.controller});

  @override
  State<ReporttabbarWidgets> createState() => _ReporttabbarWidgetsState();
}

class _ReporttabbarWidgetsState extends State<ReporttabbarWidgets> {
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
        indicator: BoxDecoration(color: AppColor.warnaPrimer),
        tabs: [
          Tab(
            child: Text(
              "Daily",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
          Tab(
            child: Text(
              "Weekly",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
          Tab(
            child: Text(
              "Monthly",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
