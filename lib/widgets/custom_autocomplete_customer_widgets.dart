import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/models/customer_models.dart';
import 'package:jajanku_pos/services/customer_services.dart';

class CustomAutocompleteCustomerWidget extends StatefulWidget {
  final String label;
  final Pelanggan? value;
  final Function(Pelanggan?) onSelected;

  const CustomAutocompleteCustomerWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onSelected,
  });

  @override
  State<CustomAutocompleteCustomerWidget> createState() =>
      _CustomAutocompleteCustomerWidgetState();
}

class _CustomAutocompleteCustomerWidgetState extends State<CustomAutocompleteCustomerWidget> {
  final TextEditingController _ctrl = TextEditingController();
  final CustomerServices _service = CustomerServices();

  @override
  void initState() {
    super.initState();
    if (widget.value != null) {
      _ctrl.text = widget.value!.namaPelanggan ?? "";
    }
  }

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

          // =============================== //
          // ==== AUTOCOMPLETE CUSTOMER ==== //
          // =============================== //
          Container(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColor.warnaPrimer,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TypeAheadField<Pelanggan>(
              builder: (context, controller, focusNode) {
                controller.text = _ctrl.text;

                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  style: AppTextstyle.normalCream,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Choose Customer . . .",
                    hintStyle: AppTextstyle.smallCream
                  ),
                  onChanged: (val) => _ctrl.text = val,
                );
              },

              suggestionsCallback: (pattern) async {
                if (pattern.isEmpty) return [];
                final all = await _service.ambilCustomer();
                return all.where((c) => c.namaPelanggan.toLowerCase().contains(pattern.toLowerCase())).toList();
              },

              itemBuilder: (context, suggestion) => ListTile(
                title: Text(suggestion.namaPelanggan ?? "",
                    style: AppTextstyle.normalCoklat),
                subtitle: Text(
                  suggestion.kodePelanggan ?? "",
                  style: AppTextstyle.normalCoklat,
                ),
              ),

              onSelected: (suggestion) {
                _ctrl.text = suggestion.namaPelanggan ?? "";
                widget.onSelected(suggestion);
              },
            ),
          ),
        ],
      ),
    );
  }
}
