import 'package:day05/models/categories_model.dart';
import 'package:day05/models/product_model.dart';
import 'package:day05/pages/screen/view_all_screen.dart';
import 'package:day05/util/constants.dart';
import 'package:day05/widget/product_item_display.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodAppHomeScreen extends StatefulWidget {
  const FoodAppHomeScreen({super.key});

  @override
  State<FoodAppHomeScreen> createState() => _FoodAppHomeScreenState();
}

class _FoodAppHomeScreenState extends State<FoodAppHomeScreen> {
  late Future<List<CategoryModel>> _futureCategories;
  late Future<List<FoodModel>> futureFoodProducts = Future.value([]);
  List<CategoryModel> categories = [];
  String? selectCategory;
  @override
  void initState() {
    super.initState();
    _futureCategories = fetchCategories();
    _futureCategories.then((loadedCategories) {
      if (!mounted || loadedCategories.isEmpty) {
        return;
      }

      setState(() {
        categories = loadedCategories;
        selectCategory ??= loadedCategories.first.name;
        futureFoodProducts = fetchFoodProduct(selectCategory!);
      });
    });
  }

  // to fetch categories from supabase and convert to category model list
  Future<List<CategoryModel>> fetchCategories() async {
    await Future.delayed(const Duration(seconds: 2));
    try {
      final dynamic response = await Supabase.instance.client
          .from('category_items')
          .select();
      print(response);

      // Some versions of the client return the list directly, others return
      // an object with a `data` property. Handle both.
      if (response is List) {
        final data = response;
        print('Fetched categories from Supabase: ${data.length}');
        return data
            .map(
              (json) => CategoryModel.fromJson(Map<String, dynamic>.from(json)),
            )
            .toList();
      }

      if (response is Map && response.containsKey('data')) {
        final data = response['data'];
        if (data is List) {
          print('Fetched categories from Supabase (wrapper): ${data.length}');
          return data
              .map(
                (json) =>
                    CategoryModel.fromJson(Map<String, dynamic>.from(json)),
              )
              .toList();
        }
      }

      print('Unexpected categories response shape: ${response.runtimeType}');
      return [];
    } catch (e, st) {
      print("Error fetching categories: $e\n$st");
      return [];
    }
  }

  //to fetch food product data from supabase and convert to product model list
  Future<List<FoodModel>> fetchFoodProduct(String category) async {
    try {
      final dynamic response = await Supabase.instance.client
          .from("food_items")
          .select()
          .eq("category", category);

      return (response as List)
          .map((json) => FoodModel.fromJson(Map<String, dynamic>.from(json)))
          .toList();
    } catch (e, st) {
      print("Error fetching food products: $e\n$st");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffdfdfd),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 85,

        title: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kgray1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Image(image: AssetImage("assets/images/dish1.png")),
            ),

            const Spacer(),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Deliver To",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: const [
                    Icon(
                      Icons.location_on_rounded,
                      color: Colors.red,
                      size: 18,
                    ),

                    SizedBox(width: 4),

                    Text(
                      "New York",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(width: 2),

                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ],
            ),

            const Spacer(),

            Container(
              height: 48,
              width: 48,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: kgray1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Image(
                image: AssetImage("assets/images/profile.png"),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            /// Greeting
            const Text(
              "Good Morning 👋",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "What would you like\nto eat today?",
              style: TextStyle(
                height: 1.2,
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            //banner section
            Container(
              width: double.infinity,
              height: 180,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffFF7A00), Color(0xffFF9F45)],
                ),

                borderRadius: BorderRadius.circular(25),

                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(.25),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    bottom: 0,
                    top: 0,
                    child: Image.asset(
                      "assets/images/courier.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Image.asset("assets/images/courier.png", fit: BoxFit.cover),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "🔥 Free Delivery",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const Spacer(),

                        const Text(
                          "The fastest delivery \n at your doorstep",
                          style: TextStyle(
                            height: 1.2,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        GestureDetector(
                          onTap: () {
                            // Handle order now action
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),

                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(30),
                            ),

                            child: const Text(
                              "Order Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            /// Search Field
            // Container(
            //   height: 58,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(18),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.black.withOpacity(.05),
            //         blurRadius: 20,
            //         offset: const Offset(0, 6),
            //       ),
            //     ],
            //   ),

            //   child: TextField(
            //     decoration: InputDecoration(
            //       border: InputBorder.none,
            //       contentPadding: const EdgeInsets.symmetric(vertical: 18),

            //       hintText: "Search food, restaurants...",
            //       hintStyle: TextStyle(
            //         color: Colors.grey.shade500,
            //         fontSize: 15,
            //       ),

            //       prefixIcon: const Icon(
            //         Icons.search_rounded,
            //         color: Colors.grey,
            //       ),

            //       suffixIcon: Container(
            //         margin: const EdgeInsets.all(8),
            //         decoration: BoxDecoration(
            //           color: Colors.orange,
            //           borderRadius: BorderRadius.circular(14),
            //         ),
            //         child: const Icon(Icons.tune_rounded, color: Colors.white),
            //       ),
            //     ),
            //   ),
            // ),
            //const SizedBox(height: 10),

            /// Categories Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                GestureDetector(
                  onTap: () {
                    // Handle "See All" action
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewAllProductsScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            _buildCategoryList(),

            const SizedBox(height: 20),
            selectCategory != null
                ? Text(
                    selectCategory!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                : const SizedBox.shrink(),

            /// Categories
            SizedBox(height: 10),
            _buildProductSection(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProductSection() {
    return SizedBox(
      height: 320,
      child: FutureBuilder<List<FoodModel>>(
        future: futureFoodProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Failed to load products"));
          }

          final products = snapshot.data ?? [];

          if (products.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];

              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 4 : 14,
                  right: index == products.length - 1 ? 4 : 0,
                ),
                child: ProductItemDisplay(foodModel: product),
              );
            },
          );
        },
      ),
    );
  }

  Widget categoryItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          height: 72,
          width: 72,
          decoration: BoxDecoration(
            color: color.withOpacity(.12),
            borderRadius: BorderRadius.circular(22),
          ),

          child: Icon(icon, color: color, size: 32),
        ),

        const SizedBox(height: 10),

        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildCategoryList() {
    return FutureBuilder<List<CategoryModel>>(
      future: _futureCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 60,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const SizedBox.shrink();
        }

        final fetchedCategories = snapshot.data ?? const <CategoryModel>[];
        if (fetchedCategories.isEmpty) {
          return const Text("No categories found.");
        }

        final currentSelection = selectCategory ?? fetchedCategories.first.name;

        return SizedBox(
          height: 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: fetchedCategories.length,
            itemBuilder: (context, index) {
              final category = fetchedCategories[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 15 : 0, right: 15),
                child: GestureDetector(
                  onTap: () => handleCategoryTap(category.name ?? ''),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: currentSelection == category.name
                          ? Colors.red
                          : kgray1,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: currentSelection == category.name
                                ? Colors.white
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            category.imageUrl ?? '',
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.fastfood),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Text(
                          category.name ?? '',
                          style: TextStyle(
                            color: currentSelection == category.name
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void handleCategoryTap(String category) {
    if (selectCategory == category) return;
    setState(() {
      selectCategory = category;
      futureFoodProducts = fetchFoodProduct(category);
    });
  }
}
