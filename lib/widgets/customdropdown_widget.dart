import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/models/category_models.dart';

class CustomdropdownWidget extends StatefulWidget {
  final String label;
  final CategoryModel? value;
  final List<CategoryModel> items;
  final Function(CategoryModel?) onChanged;

  const CustomdropdownWidget({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<CustomdropdownWidget> createState() => _CustomdropdownWidgetState();
}

class _CustomdropdownWidgetState extends State<CustomdropdownWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
    margin: const EdgeInsets.only(bottom: 13),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: AppColor.warnaSekunder,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          offset: const Offset(0, 8),
          blurRadius: 8,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppTextstyle.normalCoklat),

        const SizedBox(height: 6),

        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColor.warnaPrimer,
            borderRadius: BorderRadius.circular(15),
          ),
          child: DropdownButtonFormField<CategoryModel>(
            value: widget.value,
            icon: Icon(Icons.keyboard_arrow_down, color: AppColor.warnaSekunder),
            dropdownColor: AppColor.warnaPrimer,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            borderRadius: BorderRadius.circular(15),
            style: AppTextstyle.normalCream,
            hint: Text("Choose Category", style: AppTextstyle.normalCream),
            items: widget.items
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.namaKategori, style: AppTextstyle.normalCream),
                    ))
                .toList(),
            onChanged: widget.onChanged,
          ),
        ),
      ],
    ),
  );
  }
}
