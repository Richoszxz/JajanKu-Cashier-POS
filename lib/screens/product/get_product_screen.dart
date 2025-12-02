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
import 'package:jajanku_pos/widgets/error_handler_widget.dart';

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
    final namaController = TextEditingController(text: produk.namaProduk);
    final hargaController = TextEditingController(
      text: produk.hargaProduk.toString(),
    );

    // SnackBar khusus agar warnanya sesuai aplikasi
    void showAppSnack(String msg) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.warnaPrimer,
          content: Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }

    showDialog(
      context: context,
      barrierColor: AppColor.warnaPrimer.withOpacity(0.5),
      builder: (context) {
        // state lokal untuk dialog
        CategoryModel? selectedCat = kategori.firstWhere(
          (cat) => cat.id == produk.kategoriId,
          orElse: () => kategori.first,
        );

        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: StatefulBuilder(
            builder: (context, setStateDialog) => Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.warnaSekunder,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColor.warnaPrimer, width: 6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit Product",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColor.warnaTeks,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // NAMA
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Name", style: AppTextstyle.normalCoklat),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: namaController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.warnaPrimer,
                      hintText: "Nama Produk",
                      hintStyle: const TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: AppTextstyle.smallCream,
                  ),
                  const SizedBox(height: 16),

                  // HARGA
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Price", style: AppTextstyle.normalCoklat),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: hargaController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColor.warnaPrimer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: AppTextstyle.smallCream,
                  ),
                  const SizedBox(height: 16),

                  // KATEGORI
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Category", style: AppTextstyle.normalCoklat),
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
                        value: selectedCat,
                        dropdownColor: AppColor.warnaPrimer,
                        style: const TextStyle(color: Colors.white),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        items: kategori.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(
                              cat.namaKategori,
                              style: AppTextstyle.smallCream,
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setStateDialog(() {
                            selectedCat = value;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // SAVE BUTTON
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () async {
                        /// VALIDATION SECTION
                        if (namaController.text.trim().isEmpty) {
                          showAppSnack("Nama produk tidak boleh kosong.");
                          return;
                        }

                        if (hargaController.text.trim().isEmpty) {
                          showAppSnack("Harga tidak boleh kosong.");
                          return;
                        }

                        final harga = double.tryParse(hargaController.text);

                        if (harga == null) {
                          showAppSnack("Harga hanya boleh angka.");
                          return;
                        }

                        if (selectedCat == null) {
                          showAppSnack("Kategori harus dipilih.");
                          return;
                        }

                        final updatedProduct = Produk(
                          id: produk.id,
                          kodeProduk: produk.kodeProduk,
                          namaProduk: namaController.text,
                          hargaProduk:
                              double.tryParse(hargaController.text) ??
                              produk.hargaProduk,
                          kategoriId: selectedCat!.id!,
                          stokProduk: produk.stokProduk,
                          deskripsiProduk: produk.deskripsiProduk,
                          gambarProduk: produk.gambarProduk,
                        );

                        try {
                          await _productServices.editProduk(
                            produk.id!,
                            updatedProduct,
                          );

                          if (mounted) {
                            Navigator.pop(context); // tutup dialog
                            setState(() {}); // refresh UI
                          }
                        } catch (e) {
                          if (mounted) {
                            errorAlert(
                              context,
                              title: "Oops…",
                              text: "Gagal mengupdate produk!",
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.warnaPrimer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text("Save", style: AppTextstyle.normalCream),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
                            onPressed: () {
                              confirmAlert(
                                context,
                                title: "Delete Product?",
                                text: "Produk akan dihapus secara permanen.",
                                onConfirm: () async {
                                  try {
                                    await _productServices.hapusProduk(
                                      item.id!,
                                    );

                                    if (!mounted) return;

                                    // refresh UI setelah delete
                                    setState(() {});

                                    // langsung tutup confirm alert
                                    Navigator.pop(context);
                                  } catch (e) {
                                    if (!mounted) return;

                                    Navigator.pop(
                                      context,
                                    ); // tutup confirm alert
                                    errorAlert(
                                      context,
                                      title: "Oops…",
                                      text: "Gagal menghapus produk!",
                                    );
                                  }
                                },
                              );
                            },
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
