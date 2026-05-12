// import 'package:day05/models/product_model.dart';
// import 'package:day05/pages/screen/food_detail_screen.dart';
// import 'package:day05/provider/favourite_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class ProductItemDisplay extends ConsumerWidget {
//   final FoodModel foodModel;

//   const ProductItemDisplay({super.key, required this.foodModel});

//   @override
//   Widget build(BuildContext context , WidgetRef ref) {
//     final provider = ref.watch(favoriteProvider);
//     final size = MediaQuery.of(context).size;
//     final isFavorite = provider.isFavorite(foodModel.id ?? '');
//     return Container(
//       width: size.width * .52,
//       margin: const EdgeInsets.only(top: 20, bottom: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(.06),
//             blurRadius: 25,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),

//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// IMAGE SECTION
//           Expanded(
//             flex: 6,
//             child: Stack(
//               alignment: Alignment.topRight,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       PageRouteBuilder(
//                         transitionDuration: const Duration(milliseconds: 500),
//                         pageBuilder: (_, __, ___) =>
//                             FoodDetailScreen(foodModel: foodModel),
//                       ),
//                     );
//                   },
//                   child: Center(
//                     child: Hero(
//                       tag: foodModel.id ?? '',
//                       child: Image.network(
//                         foodModel.imageCard ??
//                             'https://via.placeholder.com/150',
//                         height: 140,
//                         fit: BoxFit.contain,
//                         errorBuilder: (context, error, stackTrace) {
//                           return const Icon(
//                             Icons.fastfood,
//                             size: 60,
//                             color: Colors.grey,
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),

//                 Positioned(
//                   left: 0,
//                   top: 0,
//                   child: Container(
//                     margin: const EdgeInsets.all(12),
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10,
//                       vertical: 6,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.orange.shade50,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.star_rounded,
//                           color: Colors.orange,
//                           size: 16,
//                         ),

//                         const SizedBox(width: 4),

//                         Text(
//                           "${foodModel.rates ?? 0}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: () {
//                       provider.toggleFavorite(foodModel.id ?? '');
//                     },
//                     child: CircleAvatar(
//                       radius: 15,
//                       backgroundColor: isFavorite ? Colors.red[100] : Colors.transparent,
//                       child: isFavorite ? Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                         size: 16,
//                       ) : Icon(
//                         Icons.favorite_border,
//                         color: Colors.grey,
//                         size: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           /// CONTENT SECTION
//           Expanded(
//             flex: 5,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     foodModel.name ?? '',
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),

//                   const SizedBox(height: 5),

//                   Text(
//                     foodModel.specialItems ?? '',
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const SizedBox(height: 5),

//                   Row(
//                     children: [
//                       Icon(
//                         Icons.local_fire_department,
//                         color: Colors.orange.shade400,
//                         size: 15,
//                       ),

//                       const SizedBox(width: 4),

//                       Text(
//                         "${foodModel.kcal} kcal",
//                         style: TextStyle(
//                           color: Colors.grey.shade700,
//                           fontSize: 10,
//                         ),
//                       ),

//                       const Spacer(),

//                       Icon(
//                         Icons.access_time_rounded,
//                         color: Colors.grey.shade500,
//                         size: 15,
//                       ),

//                       const SizedBox(width: 4),

//                       Text(
//                         foodModel.time,
//                         style: TextStyle(
//                           color: Colors.grey.shade700,
//                           fontSize: 10,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 14),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       RichText(
//                         text: TextSpan(
//                           children: [
//                             const TextSpan(
//                               text: "\$",
//                               style: TextStyle(
//                                 color: Colors.red,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),

//                             TextSpan(
//                               text:
//                                   "${foodModel.price?.toStringAsFixed(2) ?? '0.00'}",
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),

//                       Container(
//                         height: 30,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                         child: const Icon(Icons.add, color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:day05/models/product_model.dart';
import 'package:day05/pages/screen/food_detail_screen.dart';
import 'package:day05/provider/favourite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductItemDisplay extends ConsumerWidget {
  final FoodModel foodModel;

  const ProductItemDisplay({super.key, required this.foodModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(favoriteProvider);

    final isFavorite = provider.isFavorite(foodModel.id ?? '');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),

            pageBuilder: (_, __, ___) => FoodDetailScreen(foodModel: foodModel),
          ),
        );
      },

      child: Container(
        width: 210,
        margin: const EdgeInsets.only(top: 20, bottom: 10),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.06),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// IMAGE SECTION
            Expanded(
              flex: 6,
              child: Stack(
                children: [
                  /// FOOD IMAGE
                  Center(
                    child: Hero(
                      tag: foodModel.id ?? '',

                      child: Image.network(
                        foodModel.imageCard ?? '',

                        height: 140,
                        fit: BoxFit.contain,

                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.fastfood,
                            size: 60,
                            color: Colors.grey,
                          );
                        },
                      ),
                    ),
                  ),

                  /// RATING
                  Positioned(
                    left: 12,
                    top: 12,

                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),

                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: Colors.orange,
                            size: 16,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "${foodModel.rates ?? 0}",

                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// FAVORITE BUTTON
                  Positioned(
                    top: 12,
                    right: 12,

                    child: GestureDetector(
                      onTap: () {
                        provider.toggleFavorite(foodModel.id ?? '');
                      },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),

                        padding: const EdgeInsets.all(8),

                        decoration: BoxDecoration(
                          color: isFavorite
                              ? Colors.red.withOpacity(.12)
                              : Colors.white,

                          shape: BoxShape.circle,

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),

                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,

                          color: isFavorite ? Colors.red : Colors.grey,

                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// CONTENT
            Expanded(
              flex: 5,

              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 10,
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodModel.name ?? '',

                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,

                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      foodModel.specialItems ?? '',

                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const Spacer(),

                    /// INFO ROW
                    Row(
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          color: Colors.orange.shade400,
                          size: 16,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          "${foodModel.kcal} kcal",

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 11,
                          ),
                        ),

                        const Spacer(),

                        Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey.shade500,
                          size: 16,
                        ),

                        const SizedBox(width: 4),

                        Text(
                          foodModel.time,

                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    /// PRICE + BUTTON
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: "\$",

                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              TextSpan(
                                text:
                                    foodModel.price?.toStringAsFixed(2) ??
                                    '0.00',

                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          borderRadius: BorderRadius.circular(14),

                          onTap: () {},

                          child: Ink(
                            height: 40,
                            width: 40,

                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(14),
                            ),

                            child: const Icon(Icons.add, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
