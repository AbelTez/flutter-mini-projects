import 'package:day02/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/category.dart';

class CategoryWidget extends StatelessWidget {
  final Category category;
  const CategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isSelected = appState.selectedCategoryId == category.categoryId;
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          appState.updateCategoryId(category.categoryId);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: 90,
        height: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          color: isSelected ? Colors.white : Colors.transparent,
        ),
        child: Column(
          children: [
            Icon(
              category.icon,
              color: isSelected ? category.color : Colors.white,
              size: isSelected ? 40 : 30,
            ),
            SizedBox(height: 10),
            Text(
              category.name,
              style: isSelected ? selectedCategoryTextStyle : categoryTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
