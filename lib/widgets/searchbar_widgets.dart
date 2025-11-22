import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class SearchbarWidgets extends StatefulWidget {
  final String hintText;

  const SearchbarWidgets({super.key, required this.hintText});

  @override
  State<SearchbarWidgets> createState() => _SearchbarWidgetsState();
}

class _SearchbarWidgetsState extends State<SearchbarWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextstyle.smallBoldCream,
        filled: true,
        fillColor: AppColor.warnaPrimer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: AppColor.warnaSekunder)
      ),
    );
  }
}