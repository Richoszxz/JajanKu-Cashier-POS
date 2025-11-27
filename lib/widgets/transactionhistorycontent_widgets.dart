import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/constants/app_size.dart';

class TransactionhistorycontentWidgets extends StatefulWidget {
  const TransactionhistorycontentWidgets({super.key});

  @override
  State<TransactionhistorycontentWidgets> createState() =>
      _TransactionhistorycontentWidgetsState();
}

class _TransactionhistorycontentWidgetsState
    extends State<TransactionhistorycontentWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.tinggi(context) * 0.25,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Transaction Number", style: AppTextstyle.smallBoldCream),
              Text("Customer Name", style: AppTextstyle.smallBoldCream),
              Text("Items", style: AppTextstyle.smallBoldCream),
              Text("Date", style: AppTextstyle.smallBoldCream),
              Text("Payment Method", style: AppTextstyle.smallBoldCream),
              Text("Transaction Amount", style: AppTextstyle.smallBoldCream),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("CSR000001", style: AppTextstyle.smallCream),
              Text("Riche", style: AppTextstyle.smallCream),
              Text("2x Risoles Mayo, 1x Pud..", style: AppTextstyle.smallCream),
              Text("25/11/2025 09.31", style: AppTextstyle.smallCream),
              Text("Cash", style: AppTextstyle.smallCream),
              Text("Rp. 7.000", style: AppTextstyle.smallCream),
            ],
          ),
        ],
      ),
    );
  }
}
