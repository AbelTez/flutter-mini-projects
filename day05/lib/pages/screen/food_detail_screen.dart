import 'package:day05/models/product_model.dart';
import 'package:day05/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:day05/provider/favourite_provider.dart';

class FoodDetailScreen extends StatefulWidget {
  final FoodModel foodModel;

  const FoodDetailScreen({super.key, required this.foodModel});

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  int quantity = 1;

  double get totalPrice => (widget.foodModel.price ?? 0) * quantity;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kimageBackground1,

      appBar: _buildAppBar(context),

      body: Stack(
        children: [
          /// Background Pattern
          Positioned.fill(
            child: Opacity(
              opacity: .08,
              child: Image.asset(
                "assets/images/bgcheff.png",
                repeat: ImageRepeat.repeatY,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// White Bottom Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * .72,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
            ),
          ),

          /// Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// Product Image
                  Hero(
                    tag: widget.foodModel.id ?? widget.foodModel.name ?? '',
                    child: Image.network(
                      widget.foodModel.imageDetail ?? '',
                      height: 300,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.fastfood,
                          size: 120,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Quantity Selector
                  _buildQuantitySelector(),

                  const SizedBox(height: 30),

                  /// Product Name + Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.foodModel.name ?? '',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              widget.foodModel.specialItems ?? '',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "\$",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            TextSpan(
                              text: totalPrice.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  /// Food Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      foodInfo(
                        Icons.access_time_rounded,
                        widget.foodModel.time,
                      ),

                      foodInfo(Icons.star_rounded, "${widget.foodModel.rates}"),

                      foodInfo(
                        Icons.local_fire_department_rounded,
                        "${widget.foodModel.kcal} kcal",
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  /// Description
                  Text(
                    desc,
                    style: TextStyle(
                      height: 1.7,
                      color: Colors.grey.shade700,
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 40),

                  /// Order Button
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 62,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xffFF7A00), Color(0xffFF9F45)],
                        ),

                        borderRadius: BorderRadius.circular(30),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),

                      child: const Center(
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Quantity Selector
  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),

      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(40),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                });
              }
            },

            child: const Icon(Icons.remove, color: Colors.white),
          ),

          const SizedBox(width: 25),

          Text(
            quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(width: 25),

          GestureDetector(
            onTap: () {
              setState(() {
                quantity++;
              });
            },

            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// Food Info Widget
  Widget foodInfo(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.orange),

        const SizedBox(width: 6),

        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// AppBar
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceMaterialTransparency: true,

      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },

          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),

      actions: [
        Consumer(
          builder: (context, ref, child) {
            final favoritesNotifier = ref.watch(favoriteProvider);
            final productId =
                widget.foodModel.id ?? widget.foodModel.name ?? '';
            final isFavorite = favoritesNotifier.isFavorite(productId);

            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  favoritesNotifier.toggleFavorite(productId);
                },

                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Icon(
                    isFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
