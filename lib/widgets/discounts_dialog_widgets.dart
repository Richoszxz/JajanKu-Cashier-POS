import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/constants/app_size.dart';

class DiscountsDialogWidgets extends StatefulWidget {
  final Function(String) onSelected;
  const DiscountsDialogWidgets({super.key, required this.onSelected});

  @override
  State<DiscountsDialogWidgets> createState() => _DiscountsDialogWidgetsState();
}

class _DiscountsDialogWidgetsState extends State<DiscountsDialogWidgets> {
  String? selectedDiscount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: AppSize.tinggi(context) * 0.6,
          width: MediaQuery.of(context).size.width * 0.90,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.warnaSekunder,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: AppColor.warnaPrimer,
              width: 6,
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Discounts",
                style: AppTextstyle.normalCoklat.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // === DISCOUNT LIST ITEM ===
              GestureDetector(
                onTap: () {
                  setState(() => selectedDiscount = "Special Imup");
                },
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Special Imup",
                            style: AppTextstyle.normalCream
                          ),
                          Text(
                            "All category discounts 25%",
                            style: AppTextstyle.smallCream,
                          ),
                        ],
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: AppColor.warnaSekunder,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: selectedDiscount == "Special Imup"
                            ? Icon(
                                Icons.circle,
                                size: 18,
                                color: AppColor.warnaPrimer,
                              )
                            : const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 270),

              // BUTTON
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warnaPrimer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    if (selectedDiscount != null) {
                      widget.onSelected(selectedDiscount!);
                    }
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Choose Discounts",
                    style: AppTextstyle.normalCream.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
