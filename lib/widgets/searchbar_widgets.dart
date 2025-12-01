import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class SearchbarWidgets extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const SearchbarWidgets({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  State<SearchbarWidgets> createState() => _SearchbarWidgetsState();
}

class _SearchbarWidgetsState extends State<SearchbarWidgets> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(color: AppColor.warnaSekunder),
      controller: widget.controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextstyle.smallCream,
        filled: true,
        fillColor: AppColor.warnaPrimer,
        contentPadding: EdgeInsetsGeometry.symmetric(vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: AppColor.warnaSekunder, size: 30),
      ),
    );
  }
}
