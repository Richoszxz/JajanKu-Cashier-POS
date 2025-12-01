import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class PaymentMethodBottomSheetWidgets extends StatefulWidget {
  final Function(String) onSelected;
  const PaymentMethodBottomSheetWidgets({super.key, required this.onSelected});

  @override
  State<PaymentMethodBottomSheetWidgets> createState() =>
      _PaymentMethodBottomSheetWidgetsState();
}

class _PaymentMethodBottomSheetWidgetsState
    extends State<PaymentMethodBottomSheetWidgets> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.tinggi(context) * 0.26,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.warnaSekunder,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 5,
            decoration: BoxDecoration(
              color: AppColor.warnaPrimer,
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          const SizedBox(height: 25),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CASH
              GestureDetector(
                onTap: () {
                  widget.onSelected("Cash");
                  Navigator.pop(context);
                },
                child: Container(
                  width: AppSize.lebar(context) * 0.43,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.attach_money_rounded,
                        size: 60,
                        color: AppColor.warnaTeks,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Cash",
                        style: AppTextstyle.normalCream.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),

              // NON CASH
              GestureDetector(
                onTap: () {
                  widget.onSelected("Non-Cash");
                  Navigator.pop(context);
                },
                child: Container(
                  width: AppSize.lebar(context) * 0.43,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 60,
                        color: AppColor.warnaTeks,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Non-Cash",
                        style: AppTextstyle.normalCream.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
