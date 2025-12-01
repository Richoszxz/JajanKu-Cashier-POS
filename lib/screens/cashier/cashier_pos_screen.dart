import 'package:flutter/material.dart';
import 'package:jajanku_pos/screens/cashier/checkout_screen.dart';
import 'package:jajanku_pos/widgets/appbar_widget.dart';
import 'package:jajanku_pos/widgets/navigationdrawer_widget.dart';
import 'package:jajanku_pos/constants/app_color.dart';
import 'package:jajanku_pos/constants/app_textstyle.dart';
import 'package:jajanku_pos/widgets/searchbar_widgets.dart';
import 'package:jajanku_pos/widgets/card_product.dart';
import 'package:jajanku_pos/models/product_model.dart';
import 'package:jajanku_pos/services/product_services.dart';

// MODEL CART ITEM
class CartItem {
  final Produk produk;
  int qty;

  CartItem({required this.produk, this.qty = 1});
}

class CashierPosScreen extends StatefulWidget {
  const CashierPosScreen({super.key});

  @override
  State<CashierPosScreen> createState() => _CashierPosScreenState();
}

class _CashierPosScreenState extends State<CashierPosScreen> {
  final ProductServices _productServices = ProductServices();

  final List<CartItem> _cartItems = [];

  void addToCart(Produk produk) {
    setState(() {
      final index = _cartItems.indexWhere(
        (item) => item.produk.id == produk.id,
      );

      if (index != -1) {
        // Jika sudah ada, tambah qty
        _cartItems[index].qty++;
      } else {
        // Jika belum ada, tambahkan item baru
        _cartItems.add(CartItem(produk: produk, qty: 1));
      }
    });
  }

  int get totalQty {
    int total = 0;
    for (var item in _cartItems) {
      total += item.qty;
    }
    return total;
  }

  int get totalHarga {
    int total = 0;
    for (var item in _cartItems) {
      total += item.produk.hargaProduk.toInt() * item.qty;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(judulHalaman: "Cashier POS"),
      drawer: const NavigationdrawerWidget(),
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder<List<Produk>>(
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
                                ElevatedButton(
                                  onPressed: () => addToCart(item),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.warnaSekunder,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,
                                    ),
                                  ),
                                  child: Text(
                                    "Add cart",
                                    style: AppTextstyle.smallCoklat,
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
          ),

          if (_cartItems.isNotEmpty)
            Positioned(
              left: 15,
              right: 15,
              bottom: 25, // JARAK KE BAWAH → NGAMBANG!
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CheckoutScreen(cartItems: _cartItems),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColor.warnaPrimer,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cek Keranjang ($totalQty Produk)",
                        style: AppTextstyle.smallCream,
                      ),
                      Text("Rp. $totalHarga", style: AppTextstyle.smallCream),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppColor.warnaSekunder,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: AppColor.warnaTeks,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
