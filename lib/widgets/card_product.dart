import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_size.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/models/product_model.dart';

class CardProductWidget extends StatefulWidget {
  final Produk produk;
  final List<Widget> tombolAksi;
  final VoidCallback? onTap;

  const CardProductWidget({
    super.key,
    required this.produk,
    required this.tombolAksi,
    this.onTap,
  });

  @override
  State<CardProductWidget> createState() => _CardProductWidgetState();
}

class _CardProductWidgetState extends State<CardProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.lebar(context) * 0.16,
      decoration: BoxDecoration(
        color: AppColor.warnaPrimer,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- GAMBAR PRODUK ---
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
              bottom: Radius.circular(15),
            ),
            child: widget.produk.gambarProduk!.isEmpty
                ? Container(
                    height: 120,
                    color: Colors.grey[300],
                    alignment: Alignment.center,
                    child: Icon(Icons.image_not_supported, size: 40),
                  )
                : Image.network(
                    widget.produk.gambarProduk.toString(),
                    height: AppSize.tinggi(context) * 0.14,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),

          // --- NAMA PRODUK ---
          Padding(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Text(
                widget.produk.namaProduk,
                style: AppTextstyle.namaProduk,
                maxLines: 1,
              ),
            ),
          ),

          // --- HARGA & STOK ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Rp. ${widget.produk.hargaProduk} | Stok: ${widget.produk.stokProduk}",
                  style: AppTextstyle.smallCream,
                ),
              ],
            ),
          ),

          SizedBox(height: 6),

          // --- BUTTON AREA ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.tombolAksi,
            ),
          ),
        ],
      ),
    );
  }
}
