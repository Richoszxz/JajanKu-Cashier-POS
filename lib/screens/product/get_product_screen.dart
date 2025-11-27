import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/widgets/card_product.dart';
import 'package:jajanku_pos/models/product_model.dart';
import 'package:jajanku_pos/services/product_services.dart';
import 'package:jajanku_pos/widgets/searchbar_widgets.dart';
import 'package:jajanku_pos/models/category_models.dart';
import 'package:jajanku_pos/widgets/customdropdown_widget.dart';

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({super.key});

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  final ProductServices _productServices = ProductServices();

  List<CategoryModel> kategori = [];
  CategoryModel? kategoriTerpilih;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadKategori();
  }

  Future loadKategori() async {
    final result = await ProductServices().ambilKategori();

    print("Kategori ditemukan: ${result.length}");

    setState(() {
      kategori = result;
    });
  }

  void _showEditProductDialog(Produk produk) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.warnaSekunder,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppColor.warnaPrimer,
              width: 6
            )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // JUDUL
              Text(
                "Edit Product",
                style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color:  AppColor.warnaTeks,
                  ),
              ),
              const SizedBox(height: 24),

              // NAMA PRODUK
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Name",
                  style: AppTextstyle.normalCoklat,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: produk.namaProduk),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.warnaPrimer, // merah marun
                  hintText: "Risoles Mayo",
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: AppTextstyle.smallCream,
              ),
              const SizedBox(height: 16),

              // HARGA
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Price",
                  style: AppTextstyle.normalCoklat
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: produk.hargaProduk.toString()),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixStyle: const TextStyle(color: Colors.white),
                  filled: true,
                  fillColor: AppColor.warnaPrimer,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: AppTextstyle.smallCream,
              ),
              const SizedBox(height: 16),

              // KATEGORI
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Category",
                  style: AppTextstyle.normalCoklat
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColor.warnaPrimer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<CategoryModel>(
                    value: kategori.firstWhere(
                      (cat) => cat.namaKategori == produk.kategoriId,
                      orElse: () => kategori[0],
                    ),
                    dropdownColor: AppColor.warnaPrimer,
                    style: const TextStyle(color: Colors.white),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                    items: kategori.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat.namaKategori),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // TOMBOL SAVE
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.warnaPrimer,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Product"),
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            onPressed: () => _showEditProductDialog(item),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.warnaSekunder,
                              padding: EdgeInsets.symmetric(horizontal: 35),
                            ),
                            child: Text(
                              "Edit",
                              style: AppTextstyle.smallCoklat,
                            ),
                          ),
                          // TOMBOL DELETE
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.warnaTeks,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                            ),
                            child: Icon(
                              Icons.delete,
                              color: AppColor.warnaSekunder,
                            ),
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
