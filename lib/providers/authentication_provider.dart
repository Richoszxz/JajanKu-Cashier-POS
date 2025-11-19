import 'package:flutter/foundation.dart';
import 'package:jajanku_pos/services/authentication_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationServices _authService = AuthenticationServices();

  bool _isLoading = false;
  String? _message;
  Session? _session;

  bool get isLoading => _isLoading;
  String? get message => _message;
  bool get isLoggedIn => _session != null;

  AuthProvider() {
    restoreSession();
    _initAuthListener(); // dipanggil otomatis saat provider diinisialisasi
  }

  void _initAuthListener() {
  Supabase.instance.client.auth.onAuthStateChange.listen((data) {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;

    if (event == AuthChangeEvent.signedIn) {
      _session = session;
      print("🔐 Auth State: Signed In");
    } else if (event == AuthChangeEvent.signedOut) {
      _session = null;
      print("🔓 Auth State: Signed Out");
    }

    notifyListeners();  // beri tahu UI untuk update
  });
}


  Future<void> signUp(String email, String password) async {
    _setLoading(true);
    try {
      final res = await _authService.register(email, password);
      if (res.user != null) {
        _message = '✅ Akun berhasil dibuat!';
      } else {
        _message = '❌ Gagal membuat akun.';
      }
    } catch (e) {
      _message = '⚠️ Error: $e';
    }
    _setLoading(false);
  }

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final res = await _authService.signIn(email, password);
      _session = res.session;
      _message = _session != null
          ? '✅ Login berhasil untuk $email'
          : '❌ Gagal login.';
    } catch (e) {
      _message = '⚠️ Error: $e';
    }
    _setLoading(false);
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await _authService.signOut();
      _session = null;
      _message = '👋 Berhasil logout.';
    } catch (e) {
      _message = '⚠️ Error: $e';
    }
    _setLoading(false);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> restoreSession() async {
    final session = Supabase.instance.client.auth.currentSession;
    _session = session;
    notifyListeners();
    print("Session restored $_session");
  }
}
