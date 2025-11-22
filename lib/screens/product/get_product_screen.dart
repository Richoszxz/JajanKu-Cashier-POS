import 'package:flutter/material.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/card_product.dart';
import 'package:jajanku_pos/models/product_model.dart';
import 'package:jajanku_pos/services/product_services.dart';
import 'package:jajanku_pos/widgets/searchbar_widgets.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  final ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Get Product Screen"),
      drawer: const NavigationdrawerWidget(),
      body: FutureBuilder<List<Produk>>(
        future: _productServices.lihatProduk(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada produk"));
          }

          final produkList = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                // SEARCH BAR
                SearchbarWidgets(hintText: "Search product . . ."),
                SizedBox(height: 12),
                // GRID VIEW PRODUK
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: produkList.length,
                    itemBuilder: (context, index) {
                      final item = produkList[index];
                  
                      return CardProductWidget(
                        produk: item,
                        tombolAksi: [
                          // TOMBOL EDIT
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.warnaSekunder,
                              padding: EdgeInsets.symmetric(horizontal: 35)
                            ),
                            child: Text("Edit", style: AppTextstyle.smallCoklat),
                          ),
                          // TOMBOL DELETE
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.warnaTeks,
                              padding: EdgeInsets.symmetric(horizontal: 5)
                            ),
                            child: Icon(Icons.delete, color: AppColor.warnaSekunder),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
