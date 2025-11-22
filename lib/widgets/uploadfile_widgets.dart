import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';

class UploadfileWidgets extends StatefulWidget {
  final String label;

  const UploadfileWidgets({super.key, required this.label});

  @override
  State<UploadfileWidgets> createState() => _UploadfileWidgetsState();
}

class _UploadfileWidgetsState extends State<UploadfileWidgets> {
  File? _gambarTerpilih;

  Future _pilihGambar() async {
    final XFile? terpilih = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (terpilih != null) {
      setState(() {
        _gambarTerpilih = File(terpilih.path);
      });
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

          InkWell(
            onTap: _pilihGambar,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
              decoration: BoxDecoration(
                color: AppColor.warnaPrimer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  // Jika belum upload
                  if (_gambarTerpilih == null)
                    Expanded(
                      child: Text(
                        "Upload your images",
                        style: AppTextstyle.normalCream,
                      ),
                    ),

                  // Jika sudah upload → tampilkan thumbnail
                  if (_gambarTerpilih != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        _gambarTerpilih!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),

                  SizedBox(width: 10),

                  Icon(Icons.upload, color: AppColor.warnaSekunder),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
