import 'package:jajanku_pos/screens/splash_screen.dart';
import 'package:jajanku_pos/screens/get_started_screen.dart';
import 'package:jajanku_pos/screens/my_profile_screen.dart';
import 'package:jajanku_pos/screens/auth/login_screen.dart';
import 'package:jajanku_pos/screens/auth/registration_screen.dart';
import 'package:jajanku_pos/screens/dashboard_screen.dart';
import 'package:jajanku_pos/screens/cashier/cashier_pos_screen.dart';
import 'package:jajanku_pos/screens/cashier/checkout_screen.dart';
import 'package:jajanku_pos/screens/cashier/receipt_screen.dart';
import 'package:jajanku_pos/screens/product/add_product_screen.dart';
import 'package:jajanku_pos/screens/product/get_product_screen.dart';
import 'package:jajanku_pos/screens/customer/add_customer_screen.dart';
import 'package:jajanku_pos/screens/customer/get_customer_screen.dart';
import 'package:jajanku_pos/screens/customer/detail_customer_screen.dart';
import 'package:jajanku_pos/screens/customer/edit_customer_screen.dart';
import 'package:jajanku_pos/screens/transaction history/transaction_history_screen.dart';
import 'package:jajanku_pos/screens/stock/stock_product_screen.dart';
import 'package:jajanku_pos/screens/stock/product_stock_history_screen.dart';
import 'package:jajanku_pos/screens/report/sales_report_screen.dart';
import 'package:jajanku_pos/screens/report/profitloss_report_screen.dart';

class AppRoutes {
  static const splashScreen = '/splash';
  static const getStartedScreen = '/getStarted';
  static const myProfileScreen = '/myProfile';
  static const loginScreen = '/login';
  static const registrationScreen = '/registration';
  static const dashboardScreen = '/dashboard';
  static const cashierPosScreen = '/cashierPOS';
  static const checkoutScreen = '/checkout';
  static const receiptScreen = '/receipt';
  static const addProductScreen = '/addProduct';
  static const getProductScreen = '/getProduct';
  static const addCustomerScreen = '/addCustomer';
  static const getCustomerScreen = '/getCustomer';
  static const detailCustomerScreen = '/detailCustomer';
  static const editCustomerScreen = '/editCustomer';
  static const transactionHistoryScreen = '/transactionHistory';
  static const stockProductScreen = '/stockProduct';
  static const productStockHistoryScreen = '/productStockHistory';
  static const salesReportScreen = '/salesReport';
  static const profitlossReportScreen = '/profitLossReport';
  
  static final routes = {
    splashScreen: (context) => const SplashScreen(),
    getStartedScreen: (context) => const GetStartedScreen(),
    myProfileScreen: (context) => const MyProfileScreen(),
    loginScreen: (context) => const LoginScreen(),
    registrationScreen: (context) => const RegistrationScreen(),
    dashboardScreen: (context) => const DashboardScreen(),
    cashierPosScreen: (context) => const CashierPosScreen(),
    checkoutScreen: (context) => const CheckoutScreen(),
    receiptScreen: (context) => const ReceiptScreen(),
    addProductScreen: (context) => const AddProductScreen(),
    getProductScreen: (context) => const GetProductScreen(),
    addCustomerScreen: (context) => const AddCustomerScreen(),
    getCustomerScreen: (context) => const GetCustomerScreen(),
    detailCustomerScreen: (context) => const DetailCustomerScreen(),
    editCustomerScreen: (context) => const EditCustomerScreen(),
    transactionHistoryScreen: (context) => const TransactionHistoryScreen(),
    stockProductScreen: (context) => const StockProductScreen(),
    productStockHistoryScreen: (context) => const ProductStockHistoryScreen(),
    salesReportScreen: (context) => const SalesReportScreen(),
    profitlossReportScreen: (context) => const ProfitlossReportScreen(),
  };
}