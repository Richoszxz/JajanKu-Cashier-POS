import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class TextformfieldWidget extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  const TextformfieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  State<TextformfieldWidget> createState() => _TextformfieldWidgetState();
}

class _TextformfieldWidgetState extends State<TextformfieldWidget> {
  bool _isObscured = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.obscureText) {
      _isObscured = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 13),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.warnaSekunder,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 8),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(widget.label, style: AppTextstyle.normalCoklat),
          TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText ? _isObscured : false,
            style: AppTextstyle.normalCream,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColor.warnaPrimer,
              contentPadding: EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 10,
              ),
              hintText: widget.hintText,
              hintStyle: AppTextstyle.normalCream,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.warnaSekunder,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
