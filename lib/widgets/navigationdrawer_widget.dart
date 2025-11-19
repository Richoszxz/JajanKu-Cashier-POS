import 'package:flutter/material.dart';
import '../constants/app_color.dart';
import '../constants/app_textstyle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jajanku_pos/routes/app_routes.dart';

class NavigationdrawerWidget extends StatefulWidget {
  const NavigationdrawerWidget({super.key});

  @override
  State<NavigationdrawerWidget> createState() => _NavigationdrawerWidgetState();
}

class _NavigationdrawerWidgetState extends State<NavigationdrawerWidget> {
  final EdgeInsets paddingMenuIndent = const EdgeInsets.only(left: 35.0);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.warnaSekunder,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              decoration: BoxDecoration(color: AppColor.warnaPrimer),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: AppColor.warnaSekunder,
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: 120,
                            color: AppColor.warnaPrimer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text("Nama Pengguna", style: AppTextstyle.normalCream),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.myProfileScreen),
                      child: Text(
                        "My Profile",
                        style: GoogleFonts.poppins(
                          color: AppColor.warnaSekunder,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.warnaSekunder,
                          decorationThickness: 2,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Registration New Cashier",
              style: AppTextstyle.normalCoklat,
            ),
            leading: Icon(Icons.person_add, color: AppColor.warnaPrimer),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.registrationScreen);
            },
          ),
          ListTile(
            title: Text("Dashboard", style: AppTextstyle.normalCoklat),
            leading: Icon(Icons.dashboard, color: AppColor.warnaPrimer),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.dashboardScreen);
            },
          ),
          ListTile(
            title: Text("Cashier POS", style: AppTextstyle.normalCoklat),
            leading: Icon(Icons.point_of_sale, color: AppColor.warnaPrimer),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.cashierPosScreen);
            },
          ),
          ExpansionTile(
            title: Text("Product Management", style: AppTextstyle.normalCoklat),
            children: <Widget>[
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text("Product", style: AppTextstyle.normalCoklat),
                  leading: Icon(Icons.inventory, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.getProductScreen);
                  },
                ),
              ),
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text("Add Product", style: AppTextstyle.normalCoklat),
                  leading: Icon(Icons.add_box, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addProductScreen);
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              "Customer Management",
              style: AppTextstyle.normalCoklat,
            ),
            children: <Widget>[
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text("Customer", style: AppTextstyle.normalCoklat),
                  leading: Icon(Icons.people, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.getCustomerScreen);
                  },
                ),
              ),
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text("Add Customer", style: AppTextstyle.normalCoklat),
                  leading: Icon(Icons.person_add, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.addCustomerScreen);
                  },
                ),
              ),
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text(
                    "Transaction History",
                    style: AppTextstyle.normalCoklat,
                  ),
                  leading: Icon(Icons.history, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.transactionHistoryScreen);
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Stock Management", style: AppTextstyle.normalCoklat),
            children: <Widget>[
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text(
                    "Product Stock",
                    style: AppTextstyle.normalCoklat,
                  ),
                  leading: Icon(Icons.store, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.stockProductScreen);
                  },
                ),
              ),
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text(
                    "Product Stock History",
                    style: AppTextstyle.normalCoklat,
                  ),
                  leading: Icon(Icons.history, color: AppColor.warnaPrimer),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.productStockHistoryScreen);
                  },
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Report and Print", style: AppTextstyle.normalCoklat),
            children: <Widget>[
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text("Sales Report", style: AppTextstyle.normalCoklat),
                  leading: Icon(
                    Icons.insert_chart,
                    color: AppColor.warnaPrimer,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.salesReportScreen);
                  },
                ),
              ),
              Padding(
                padding: paddingMenuIndent,
                child: ListTile(
                  title: Text(
                    "Profit & Loss Report",
                    style: AppTextstyle.normalCoklat,
                  ),
                  leading: Icon(
                    Icons.insert_chart,
                    color: AppColor.warnaPrimer,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.profitlossReportScreen);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
