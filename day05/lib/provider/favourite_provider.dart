import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// PROVIDER
final favoriteProvider = ChangeNotifierProvider<FavoriteProvider>(
  (ref) => FavoriteProvider(),
);

class FavoriteProvider extends ChangeNotifier {
  /// SUPABASE
  final SupabaseClient _supabase = Supabase.instance.client;

  /// AUTH SUBSCRIPTION
  late final StreamSubscription<AuthState> _authSubscription;

  /// FAVORITE IDS
  List<String> _favoriteIds = [];

  /// LOADING STATE
  bool _isLoading = false;

  FavoriteProvider() {
    _authSubscription = _supabase.auth.onAuthStateChange.listen((data) {
      if (data.session == null) {
        reset();
        return;
      }

      loadFavorites();
    });

    if (userId != null) {
      loadFavorites();
    }
  }

  /// GETTERS
  List<String> get favoriteIds => _favoriteIds;

  bool get isLoading => _isLoading;

  String? get userId => _supabase.auth.currentUser?.id;

  /// CHECK FAVORITE
  bool isFavorite(String productId) {
    return _favoriteIds.contains(productId);
  }

  /// LOAD FAVORITES
  Future<void> loadFavorites() async {
    if (userId == null) return;

    try {
      _isLoading = true;
      notifyListeners();

      final response = await _supabase
          .from('favorites')
          .select('product_id')
          .eq('user_id', userId!);

      _favoriteIds = (response as List)
          .map((item) => item['product_id'].toString())
          .toList();

      notifyListeners();
    } catch (e) {
      debugPrint('Load favorites error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// ADD FAVORITE
  Future<void> addFavorite(String productId) async {
    if (userId == null) return;

    try {
      /// PREVENT DUPLICATES
      if (_favoriteIds.contains(productId)) {
        return;
      }

      await _supabase.from('favorites').insert({
        'user_id': userId,
        'product_id': productId,
      });

      _favoriteIds.add(productId);

      notifyListeners();
    } catch (e) {
      debugPrint('Add favorite error: $e');
    }
  }

  /// REMOVE FAVORITE
  Future<void> removeFavorite(String productId) async {
    if (userId == null) return;

    try {
      await _supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId!)
          .eq('product_id', productId);

      _favoriteIds.remove(productId);

      notifyListeners();
    } catch (e) {
      debugPrint('Remove favorite error: $e');
    }
  }

  /// TOGGLE FAVORITE
  Future<void> toggleFavorite(String productId) async {
    if (isFavorite(productId)) {
      await removeFavorite(productId);
    } else {
      await addFavorite(productId);
    }
  }

  /// RESET ON LOGOUT
  void reset() {
    _favoriteIds = [];
    _isLoading = false;

    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}
