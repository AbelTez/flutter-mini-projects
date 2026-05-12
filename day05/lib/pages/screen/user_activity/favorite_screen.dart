import 'package:day05/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    final userId = supabase.auth.currentSession?.user.id;

    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          "Favorite Products",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      body: userId == null
          ? const Center(
              child: Text(
                "Please login first.",
                style: TextStyle(fontSize: 16),
              ),
            )
          : StreamBuilder<List<Map<String, dynamic>>>(
              stream: supabase
                  .from('favorites')
                  .stream(primaryKey: ['id'])
                  .eq('user_id', userId),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text("Something went wrong"));
                }

                final favorites = snapshot.data ?? [];

                if (favorites.isEmpty) {
                  return const Center(
                    child: Text(
                      "No favorite products yet.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                return FutureBuilder<List<FoodModel>>(
                  future: fetchFavoriteItems(favorites),

                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final favoriteItems = productSnapshot.data ?? [];

                    if (favoriteItems.isEmpty) {
                      return const Center(
                        child: Text("No favorite items found."),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: favoriteItems.length,

                      itemBuilder: (context, index) {
                        final item = favoriteItems[index];

                        return _buildFavoriteCard(item);
                      },
                    );
                  },
                );
              },
            ),
    );
  }

  /// FETCH FAVORITE PRODUCTS
  Future<List<FoodModel>> fetchFavoriteItems(
    List<Map<String, dynamic>> favorites,
  ) async {
    try {
      final productIds = favorites
          .map((fav) => fav['product_id'].toString())
          .toList();

      if (productIds.isEmpty) {
        return [];
      }

      final response = await supabase
          .from('food_items')
          .select()
          .inFilter('id', productIds);

      return (response as List)
          .map((json) => FoodModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e) {
      debugPrint("Favorite fetch error: $e");
      return [];
    }
  }

  /// REMOVE FAVORITE
  Future<void> removeFavorite(String productId) async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) return;

    try {
      await supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('product_id', productId);
    } catch (e) {
      debugPrint("Remove favorite error: $e");
    }
  }

  /// FAVORITE CARD
  Widget _buildFavoriteCard(FoodModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Row(
        children: [
          /// IMAGE
          Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),

              image: DecorationImage(
                image: NetworkImage(item.imageCard ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 4),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          removeFavorite(item.id ?? '');
                        },

                        child: Container(
                          padding: const EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(.1),

                            shape: BoxShape.circle,
                          ),

                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Text(
                    item.category ?? '',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.orange,
                        size: 18,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        "${item.rates ?? 0}",
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),

                      const SizedBox(width: 16),

                      const Icon(
                        Icons.access_time,
                        size: 18,
                        color: Colors.grey,
                      ),

                      const SizedBox(width: 4),

                      Text(
                        item.time,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  Text(
                    "\$${item.price?.toStringAsFixed(2) ?? '0.00'}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
